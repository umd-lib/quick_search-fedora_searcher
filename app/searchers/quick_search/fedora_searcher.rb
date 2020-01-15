# frozen_string_literal: true

module QuickSearch
  # QuickSearch seacher for Fedora via Hippo CMS
  class FedoraSearcher < QuickSearch::Searcher
    def search
      resp = @http.get(search_url)
      @response = JSON.parse(resp.body)
    end

    def results
      return @results_list if @results_list

      @results_list = @response['items'].map do |value|
        result = OpenStruct.new(title: value['display_title'],
                                link: value['item_link'],
                                description: build_description_block(value['annotations']),
                                date: build_date(value['date']))
        result
      end

      @results_list
    end

    def build_date(date_in_millis)
      return if date_in_millis.nil?

      date = Time.at(date_in_millis / 1000).utc.to_date
      date.strftime('%b %d, %Y')
    end

    def build_description_block(annotations)
      return '' if annotations.nil?

      # Only allow the HTML "bold" tag (<b>), as that is used for highlighting
      description = annotations.join('...')
      sanitize(description, tags: ['b'])
    end

    def search_url
      base = URI.parse QuickSearch::Engine::FEDORA_CONFIG['search_url']
      search_term = http_request_queries['not_escaped']
      base.query = { 'query' => search_term }.merge('pageSize' => QuickSearch::Engine::APP_CONFIG['per_page']).to_query
      base
    end

    def total
      @response['totalCount']
    end

    def loaded_link
      QuickSearch::Engine::FEDORA_CONFIG['loaded_link'] +
        QuickSearch::Engine::FEDORA_CONFIG['query_params'] +
        http_request_queries['uri_escaped']
    end
  end
end
