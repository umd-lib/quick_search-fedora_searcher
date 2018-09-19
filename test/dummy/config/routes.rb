Rails.application.routes.draw do
  mount QuickSearchFedoraSearcher::Engine => "/quick_search-fedora_searcher"
end
