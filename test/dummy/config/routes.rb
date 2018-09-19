Rails.application.routes.draw do
  mount QuickSearch::FedoraSearcher::Engine => "/quick_search-fedora_searcher"
end
