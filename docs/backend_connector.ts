// ****** Copied from 'e2e_tests_connector' gem ********
export {};

// ********* INTEGRATE CONNECTOR COMMANDS ON CYPRESS
declare namespace Cypress {
  interface Chainable<Subject> {
    serverCommand(kind: string, commands: string|string[], params?: object): Chainable<any>
    initCustomMocks(): Chainable<any>
    resetDb(): Chainable<any>
    cmd(cmd: string|string[]): Chainable<any>
    factory(factoryCmd: string|string[], jsonArgs?: string|object): Chainable<any>
  }
}

// ********* DEFINE CONNECTOR COMMANDS
// Backend server connector
Cypress.Commands.add('serverCommand', (kind: string, commands: string|string[], params = {}) => {
  const body = Object.assign(params, { kind, commands });
  cy.log('Running command...: ', body);
  return cy.request({
    method: 'POST',
    url: `${Cypress.env('BACKEND_URL')}/e2e_tests_connector/call.json`,
    body: JSON.stringify(body),
    log: true,
    failOnStatusCode: true,
    headers: {
      'Content-Type': 'application/json',
    },
  });
});

// Run any command(s) on server side
Cypress.Commands.add('cmd', (cmd: string|string[]) => {
  cy.serverCommand('cmd', cmd).then((res: any) => res.body.res);
});

// Run factory command(s) on server side
Cypress.Commands.add('factory', (factoryCmd: string|string[], jsonArgs?: string|object) => {
  cy.serverCommand('factory', factoryCmd, { jsonArgs }).then((res:any) => res.body.res);
});

// Reset DB on server side for each test before running
Cypress.Commands.add('resetDb', () => cy.serverCommand('reset_db', ''));

// Initialize all defined custom mocks on server side before starting to run all tests
Cypress.Commands.add('initCustomMocks', () => cy.serverCommand('init_custom_mocks', ''));

// ********* SETUP INITIALIZATIONS
beforeEach(() => cy.resetDb()); // reset database for each test
before(() => cy.initCustomMocks()); // init custom e2e mocks before running tests
