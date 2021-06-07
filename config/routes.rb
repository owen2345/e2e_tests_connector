# frozen_string_literal: true

E2eTestsConnector::Engine.routes.draw do
  match 'call', to: 'connector#call', via: %i[get post]
end
