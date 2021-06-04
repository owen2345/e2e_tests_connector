Rails.application.routes.draw do
  mount E2eTestsConnector::Engine => "/e2e_tests_connector"
end
