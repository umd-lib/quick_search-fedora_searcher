# frozen_string_literal: true

require 'test_helper'

module QuickSearch
  # Tests for FedoraSearcher
  class FedoraSearcher::Test < ActiveSupport::TestCase # rubocop:disable Style/ClassAndModuleChildren
    test 'truth' do
      assert_kind_of Module, QuickSearch::FedoraSearcher
    end

    test 'build_description_block should return an empty string if annotations is nil' do
      searcher = QuickSearch::FedoraSearcher.new(nil, nil, nil)

      annotations = nil
      assert_equal '', searcher.build_description_block(annotations)
    end

    test 'build_description_block should return a string if annotations not nil' do
      searcher = QuickSearch::FedoraSearcher.new(nil, nil, nil)

      annotations = ['First line', '<b>Second</b> line', 'Third line']
      assert_equal 'First line...<b>Second</b> line...Third line',
                   searcher.build_description_block(annotations)
    end

    test 'build_description_block should strip all HTML tags except <b>' do
      searcher = QuickSearch::FedoraSearcher.new(nil, nil, nil)

      annotations = ['<h1>First line</h1>', '<b>Second</b> line', '<div>Third line</div>']
      assert_equal 'First line...<b>Second</b> line...Third line',
                   searcher.build_description_block(annotations)
    end

    test 'results should return a list of results' do
      searcher = QuickSearch::FedoraSearcher.new(nil, nil, nil)
      searcher.instance_variable_set(:@response, JSON.parse(example_json_response))
      results_list = searcher.results

      assert_equal 3, results_list.size

      # Check dates
      assert_equal 'Mar 01, 1978', results_list[0].date
      assert_equal 'Feb 28, 1972', results_list[1].date
      assert_equal 'Oct 18, 1972', results_list[2].date

      # Check the total number found
      assert_equal 720, searcher.total
    end

    # Returns a string containing a sample JSON response, obtained by running:
    #
    # http://localhost:8080/site/digital/searchnew/json?query=McKeldin&pageSize=3
    #
    # against a local Hippo CMS instance with LIBWEB-4412 implemented
    def example_json_response
      <<-'JSON_EXAMPLE'
        {
          "query": "McKeldin",
          "totalCount": 720,
          "items": [
            {
              "date": 257558400000,
              "collection_title_facet": [
                "UMD Student Newspapers"
              ],
              "id": "https://fcrepodev.lib.umd.edu/fcrepo/rest/pcdm/a8/8d/6d/bf/a88d6dbf-d995-4f39-adc3-11d770ee8c65",
              "component_not_tokenized": "Page",
              "display_title": "Argus (College Park, Md.), 1978-03-01, page 6",
              "annotations": [
                "\nUniversity to run for governor against his incumbent\nnemesis, Theodore <b>McKeldin,</b> the school was still\nunder o two-year probation on its accreditation,"
              ],
              "item_link": "http://localhost:8080/site/digital/result/id/a88d6dbf-d995-4f39-adc3-11d770ee8c65?query=McKeldin"
            },
            {
              "date": 68083200000,
              "collection_title_facet": [
                "UMD Student Newspapers"
              ],
              "id": "https://fcrepodev.lib.umd.edu/fcrepo/rest/pcdm/fb/03/c4/91/fb03c491-b891-44e1-9a68-cf5a76525227",
              "component_not_tokenized": "Page",
              "display_title": "The diamondback (College Park, Md.), 1972-02-28, page 6",
              "annotations": [
                "Last week the physical plant cleaned off the pigeon droppings at the base of the pillars in front of\n<b>McKeldin</b> library. Mounds",
                "\nmeeting at 8 p.m. in room 1008\nof <b>McKeldin</b> library. Divine\nPrinciple will be taught.\n• Motorcycle club will hold\na mechanics course at 7"
              ],
              "item_link": "http://localhost:8080/site/digital/result/id/fb03c491-b891-44e1-9a68-cf5a76525227?query=McKeldin"
            },
            {
              "date": 88214400000,
              "collection_title_facet": [
                "UMD Student Newspapers"
              ],
              "id": "https://fcrepodev.lib.umd.edu/fcrepo/rest/pcdm/5f/26/c4/e2/5f26c4e2-85ea-488a-8f99-908beac524d3",
              "component_not_tokenized": "Page",
              "display_title": "The diamondback (College Park, Md.), 1972-10-18, page 3",
              "annotations": [
                "photo by Michael salser\nDenouncing political repression, 14 protesters marched from <b>McKeldin</b> library to\nthe main administration building last Tuesday.",
                " by 14\nprotesters from <b>McKeldin</b>\nlibrary to the main ad­\nministration building. The num­\nber of marchers was increased\nby two over the"
              ],
              "item_link": "http://localhost:8080/site/digital/result/id/5f26c4e2-85ea-488a-8f99-908beac524d3?query=McKeldin"
            }
          ]
        }
      JSON_EXAMPLE
    end
  end
end
