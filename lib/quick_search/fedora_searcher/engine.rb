module QuickSearch
  module FedoraSearcher
    class Engine < ::Rails::Engine
      isolate_namespace QuickSearch::FedoraSearcher
    end
  end
end
