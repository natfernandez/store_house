require 'spec_helper'

RSpec.describe CostsController, :type => :controller do
  routes { StoreHouse::Application.routes }
  let(:cost) { stub_model(Cost, { id: 1 , article_id: 15, raw_material: 100.30} ) }
  let(:cost_params) { {'raw_material' => 99.0} }
  let(:errors) { double 'Errors' }

  describe 'GET #index' do
    it 'returns all costs and renders index view' do
      expect(Cost).to receive(:all)
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new costs controller' do
    it 'creates a new cost instance' do
      get :new
      cost = assigns[:cost]
      expect(cost).to be_present
    end

    it 'render cost template cost template new' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create costs controller' do
    it 'creates a new contact instance and response success' do
      expect(Cost).to receive(:new).and_return cost
      allow(cost).to receive(:save).and_return true
      post :create, cost_params
      expect(response).to be_success
    end

    it 'renders cost template index when all is ok' do
      allow(Cost).to receive(:new).and_return cost
      allow(cost).to receive(:save).and_return true
      post :create, cost_params
      expect(response).to render_template(:index)
    end

    it 'renders cost template new and shows errors when any is failed ' do
      allow(Cost).to receive(:new).and_return(cost)
      allow(cost).to receive(:save).and_return false
      allow(cost).to receive(:valid?).and_return false
      allow(cost).to receive(:errors).and_return errors
      allow(errors).to receive(:messages).and_return(:foo =>['Bar'])
      post :create, cost_params
      expect(cost.errors.messages[:foo]).to include('Bar')
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #update cost controller' do
    it 'finds the cost_id passed' do
      expect(Cost).to receive(:find_by_id).and_return cost
      put :update, id: '18', cost: cost_params
    end

    it 'updates cost with params passed' do
      allow(Cost).to receive(:find_by_id).and_return cost
      expect(cost).to receive(:update_attributes).and_return true
      put :update, id: '18', cost: cost_params
    end

    it' renders the cost template' do
      allow(Cost).to receive(:find_by_id).and_return(cost)
      allow(cost).to receive(:try).and_return true
      put :update, id: '8', cost: cost_params
      expect(response).to render_template(:index)
    end

    it' renders the cost show template and shows errors' do
      allow(Cost).to receive(:find_by_id).and_return(cost)
      allow(cost).to receive(:try).and_return nil
      allow(cost).to receive(:valid?).and_return false
      allow(cost).to receive(:errors).and_return errors
      allow(errors).to receive(:messages).and_return(:foo => ['Bar'])
      put :update, id: '8', cost: cost_params
      expect(cost.errors.messages[:foo]).to include('Bar')
      expect(response).to render_template(:show)
    end
  end
end
