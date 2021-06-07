# frozen_string_literal: true

E2eTestsConnector::Engine.routes.draw do
  scope :e2e_tests_connector do
    match 'call', to: 'connector#call', via: %i[get post]
  end
end
