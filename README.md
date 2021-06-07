# E2eTestsConnector
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'e2e_tests_connector'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install e2e_tests_connector
```

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
