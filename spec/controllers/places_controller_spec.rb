require 'rails_helper'

RSpec.describe PlacesController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @places' do
      expect(assigns(:places).first).to be_a(Grom::Node)
      expect(assigns(:places).first.type).to eq('http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion')
    end

    it 'assigns @places by GSS code' do
      places = assigns(:places)
      expect(places[0].gss_code).to eq('gssCode - 1')
      expect(places[1].gss_code).to eq('gssCode - 10')
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

  end

end
