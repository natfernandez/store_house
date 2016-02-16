require 'spec_helper'

RSpec.describe BusinessDataController, :type => :controller do
  routes { StoreHouse::Application.routes }
  let(:business_data) { double('BusinnesData',{ id: 18 , name: 'Business', tax_number: '12345678F'} ) }

  describe 'GET #new business_data controller' do
    it 'creates a new business_data instance' do
      get :new
      business_data = assigns[:business_data]
      expect(business_data).to be_present
    end

    it 'render business_data template business_data template new' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create business_data controller' do
    let(:business_params) { {'name' => 'business_data One', 'tax_number:' => '12345678F'} }
    it 'creates a new business_data instance and response success' do
      expect(BusinessData).to receive(:new).and_return(business_data)
      expect(business_data).to receive(:save).and_return(true)
      post :create, business_params
      expect(response).to be_success
    end

    it 'renders business_data template index when all is ok' do
      allow(BusinessData).to receive(:new).and_return(business_data)
      allow(business_data).to receive(:save).and_return true
      post :create, business_params
      expect(response).to render_template(:index)
    end

    let(:errors) { double ('Errors') }
    it 'renders business_data template new and shows errors when any is failed ' do
      allow(BusinessData).to receive(:new).and_return(business_data)
      allow(business_data).to receive(:save).and_return false
      allow(business_data).to receive(:valid?).and_return false
      allow(business_data).to receive(:errors).and_return errors
      allow(errors).to receive(:messages).and_return(:foo => ['Bar'])
      post :create, :business_data => {'name' => 'business_data Two'}
      expect(business_data.errors[:foo]).to include('Bar')
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #update business_data controller' do
    it 'finds the business_id passed' do
      binding.pry
      expect(BusinessData).to receive(:find_by_id).and_return business_data
      put :update, id: '18', business_data: {:name => 'Foo'}
      expect(assigns[:business_data]).to eq(business_data)
    end

    it 'updates business_data with params passed' do
      allow(BusinessData).to receive(:find_by_id).and_return business_data
      put :update, id: '18', business_data: {:name => 'Foo'}
      expect(business_data.name).to eq('Foo')
    end

    it' renders the business_data template' do
      allow(BusinessData).to receive(:find_by_id).and_return(business_data)
      put :update, id: '8', business_data: {:name => 'Foo'}
      expect(response).to render_template(:index)
    end
  end
end
