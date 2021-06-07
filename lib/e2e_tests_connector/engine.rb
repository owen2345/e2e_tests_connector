# frozen_string_literal: true

module E2eTestsConnector
  class Engine < ::Rails::Engine
    isolate_namespace E2eTestsConnector
  end
end
