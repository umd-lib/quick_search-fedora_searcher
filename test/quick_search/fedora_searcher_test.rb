# frozen_string_literal: true

require 'test_helper'

module QuickSearch
  class FedoraSearcher
    # FedoraSearcher tests
    class Test < ActiveSupport::TestCase
      test 'truth' do
        assert_kind_of Module, QuickSearch::FedoraSearcher
      end
    end
  end
end
