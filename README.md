# E2eTestsConnector
![Rails 4+](https://img.shields.io/badge/Rails-4+-success.png)
![Ruby 2.4+](https://img.shields.io/badge/Ruby-2.4+-success.png)
![Production ready](https://img.shields.io/badge/Production-ready-success.png)

This gem permits to connect frontend apps like react, angular, etc with backend rails apps to run end to end tests using libraries like [cypress](https://www.cypress.io/)

## Backend Installation
- Add dependency    
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
- Mount route      
  ```ruby
    mount E2eTestsConnector::Engine, at: '/e2e_tests_connector'
  ```

## Frontend Installation
- Copy [backend_connector.ts](/docs/backend_connector.ts?raw=true) into `cypress/support/backend_connector.ts` 
- Import the connector in `cypress/support/index.js`
  `import './backend_connector';`

## Configuration
Optionally change default configurations when using custom factories or database cleaners
```ruby
# config/initializers/e2e_tests_connector.rb
return unless defined?(E2eTestsConnector)

E2eTestsConnector::Config.init_custom_mocks = lambda do |_params|
  # here custom mocks or initializers when starting e2e tests (default empty) 
end

E2eTestsConnector::Config.reset_db = lambda do |_params|
  # here custom database cleaner (default DatabaseCleaner.clean) 
end

E2eTestsConnector::Config.run_factory = lambda do |_params|
  # here custom factory builder (default FactoryBot) 
end
```

## Running
- Start test applications, like:    
  `cd backend_app/ && RAILS_ENV=test bundle exec rails s -e test -p 3001 &`    
  `cd frontend_app/ && PORT=3000 BROWSER=none RAILS_PORT=3001 yarn start test --silent &`    
- Run e2e tests (hosts and ports may vary based on your test apps)    
  `CYPRESS_BASE_URL=http://localhost:3000 CYPRESS_BACKEND_URL=http://localhost:3001 yarn cypress run`
  
## Samples
- Factory command
  ```typescript
    // Multiple values
    cy.factory('create_list(:article, 2)').as('articles');
    // => [{ id: 1, title: "Sample article", created_at: "..", ... }, { id: 2, title: "Sample article", created_at: "..", ... }]
  
    // Provide custom data
    cy.factory('create(:article, title: "Sample article")').as('article');
    // => { id: 1, title: "Sample article", created_at: "..", ... }
  
    // Return custom data
    cy.factory('create(:article).as_json(only: [:id, :title])').as('article');
    // => { id: 1, title: "..." }
  
    // Multiple commands
    cy.factory(['create(:article, kind: :external)', 'create(:article, kind: :internal)']).as('articles');
    // => [{ id: 1, title: "..", kind: "external", ... }, { id: 2, title: "..", kind: "internal", ... }]
  ```
- Custom command
  ```typescript
    // Single value
    cy.cmd('Article.find(1)').as('article');
    // => { id: 1, title: "..", kind: "external", ... }  
  
    // Multiple values
    cy.cmd('Article.where(kind: :external)').as('articles');
    // => [{ id: 1, title: "..", kind: "external", ... }, { id: 2, title: "..", kind: "external", ... }, ...]
  
    // Multiple commands
    cy.cmd(['Article.find(1)', 'Article.find(2)']).as('articles');
    // => [{ id: 1, title: "..", kind: "external", ... }, { id: 2, title: "..", kind: "internal", ... }]
  ```
- Full example
  ```typescript
    describe('When listing articles', () => {
      beforeEach(() => {
        // cy.stubLoginWith();
        cy.factory('create_list(:article, 2)').as('articles');
      });
      
      it('includes all expected articles', function () {
        cy.visit('/articles');
        cy.get('table tbody tr').should('have.length', this.articles.length);
      });
     
      describe('When filtering', () => {
        it('returns expected article', function () {
          const article = this.articles[0];
          cy.visit(`/articles/filter=${article.number}`);
          cy.get('table').contains(article.number);
        });
      });
    });
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
