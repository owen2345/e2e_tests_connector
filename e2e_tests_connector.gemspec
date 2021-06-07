# frozen_string_literal: true

require_relative 'lib/e2e_tests_connector/version'

Gem::Specification.new do |spec|
  spec.name        = 'e2e_tests_connector'
  spec.version     = E2eTestsConnector::VERSION
  spec.authors     = ['owen2345']
  spec.email       = ['owenperedo@gmail.com']
  spec.homepage    = 'https://github.com/owen2345/e2e_tests_connector'
  spec.summary     = 'Permits to connect frontend apps with backend apps to run e2e tests like cypress'
  spec.description = 'Permits to connect frontend apps with backend apps to run e2e tests like cypress'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://github.com/owen2345/e2e_tests_connector'
  spec.required_ruby_version = '>= 2.2' # rubocop:disable Gemspec/RequiredRubyVersion
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/owen2345/e2e_tests_connector'
  spec.metadata['changelog_uri'] = 'https://github.com/owen2345/e2e_tests_connector'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails'
end
