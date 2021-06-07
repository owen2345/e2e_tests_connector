# frozen_string_literal: true

require 'rails_helper'
RSpec.describe E2eTestsConnector::ConnectorController, type: :controller do
  routes { E2eTestsConnector::Engine.routes }
  let(:name1) { 'User 1' }
  let(:name2) { 'User 2' }

  describe 'when resetting database' do
    let(:kind) { :reset_db }

    it 'resets database data' do
      create(:user)
      expect(DatabaseCleaner).to receive(:clean)
      post :call, params: { kind: kind }
    end
  end

  describe 'when running a factory bot command' do
    let(:kind) { :factory }

    it 'performs and returns results of the provided command' do
      cmd = "create(:user, name: '#{name1}')"
      post :call, params: { kind: kind, commands: cmd }
      expect(parsed_response[:name]).to eq name1
    end

    it 'performs and returns results of the provided multiple commands' do
      cmd = ["create(:user, name: '#{name1}')", "create(:user, name: '#{name2}')"]
      post :call, params: { kind: kind, commands: cmd }
      exp_result = [parsed_response[0][:name], parsed_response[1][:name]]
      expect(exp_result).to eq [name1, name2]
    end
  end

  describe 'when running a ruby command' do
    let(:kind) { :custom }
    let!(:user1) { create(:user, name: 'original name1') }
    let!(:user2) { create(:user, name: 'original name2') }

    describe 'single command' do
      before do
        cmd = "user = User.find(#{user1.id}); user.update!(name: '#{name1}'); user.as_json"
        post :call, params: { kind: kind, commands: cmd }
      end

      it 'performs the provided command' do
        expect(user1.reload.name).to eq name1
      end

      it 'returns the result of the command' do
        expect(parsed_response[:name]).to eq name1
      end
    end

    it 'performs provided multiple commands' do
      cmd = %W[User.find(#{user1.id}).as_json User.find(#{user2.id}).as_json]
      post :call, params: { kind: kind, commands: cmd }
      exp_result = [parsed_response[0][:name], parsed_response[1][:name]]
      expect(exp_result).to eq [user1.name, user2.name]
    end
  end

  describe 'when initializing custom mocks' do
    let(:kind) { :init_custom_mocks }

    it 'initializes custom mocks' do
      callback = E2eTestsConnector::Config.init_custom_mocks
      expect(callback).to receive(:call)
      post :call, params: { kind: kind }
    end
  end

  private

  def parsed_response
    JSON.parse(response.body).deep_symbolize_keys[:res]
  end
end
