# frozen_string_literal: true

require 'rspec/rails' if defined?(RSpec)
require './spec/rails_helper' if defined?(RSpec)
require 'database_cleaner/active_record' if defined?(DatabaseCleaner)

module E2eTestsConnector
  class Config
    # By default void
    # @return nil
    cattr_accessor :init_custom_mocks do
      lambda do |_params|
      end
    end

    # By default using database cleaner
    # @return nil
    cattr_accessor :reset_db do
      lambda do |_params|
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean
      end
    end

    # By default using factory bot
    # @return (Array<ActiveRecord>)
    cattr_accessor :run_factory do
      lambda do |params|
        Array(params[:commands]).map do |cmd|
          FactoryBot.class_eval(cmd).as_json(params[:jsonArgs])
        end
      end
    end
  end
end
