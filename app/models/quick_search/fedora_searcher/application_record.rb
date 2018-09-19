module QuickSearch
  module FedoraSearcher
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
