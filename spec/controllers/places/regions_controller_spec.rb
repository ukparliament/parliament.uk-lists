require 'rails_helper'

RSpec.describe Places::RegionsController, vcr: true do

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

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
        {
          route: 'index',
          data_url: "#{ENV['PARLIAMENT_BASE_URL']}/region_index"
        }
      ]

      before(:each) do
        headers = { 'Accept' => 'application/rdf+xml' }
        request.headers.merge(headers)
      end

      it 'should have a response with http status redirect (302)' do
        methods.each do |method|
          if method.include?(:parameters)
            get method[:route].to_sym, params: method[:parameters]
          else
            get method[:route].to_sym
          end
          expect(response).to have_http_status(302)
        end
      end

      it 'redirects to the data service' do
        methods.each do |method|
          if method.include?(:parameters)
            get method[:route].to_sym, params: method[:parameters]
          else
            get method[:route].to_sym
          end
          expect(response).to redirect_to(method[:data_url])
        end
      end
    end
  end
end
