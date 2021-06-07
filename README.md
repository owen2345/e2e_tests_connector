# E2eTestsConnector


## Usage
This gem permits to connect frontend apps like react, angular, etc with backend rails apps to run end to end tests using libraries like [cypress](https://www.cypress.io/)

## Installation
Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'e2e_tests_connector'
end
```

And then execute:
```bash
$ bundle install
```

## Frontend Integration
- Copy `docs/backend_connector.ts` into `cypress/support/` 
- Import the connector in `cypress/support/index.js`
  `import './backend_connector';`

## Troubleshooting
- `uninitialized constant E2eTestsConnector::Config::DatabaseCleaner`
  Require the corresponding library in `spec/spec_helper.rb`
  ```ruby
    require 'factory_bot_rails' # OR
    require 'database_cleaner/active_record'
  ```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
