# frozen_string_literal: true

module E2eTestsConnector
  class ConnectorController < ApplicationController
    def call
      case params[:kind]
      when 'reset_db'
        run_reset_db
      when 'factory'
        run_factory
      when 'init_default_mocks'
        init_custom_mocks
      else
        run_command
      end
    end

    private

    def single_command?
      params[:commands].is_a?(String)
    end

    def run_reset_db
      E2eTestsConnector::Config.reset_db.call(params)
      render json: { res: nil }
    end

    def run_factory
      res = E2eTestsConnector::Config.run_factory.call(params)
      render json: { res: single_command? ? res.first : res }
    end

    def run_command
      res = Array(params[:commands]).map { |cmd| eval(cmd) } # rubocop:disable Security/Eval
      render json: { res: single_command? ? res.first : res }
    end

    def init_custom_mocks
      E2eTestsConnector::Config.init_custom_mocks.call(params)
      render json: { res: nil }
    end
  end
end
