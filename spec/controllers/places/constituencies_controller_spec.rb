require 'rails_helper'

RSpec.describe Places::ConstituenciesController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index, params: { place_id: 'E15000001' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @place' do
      expect(assigns(:place)).to be_a(Grom::Node)
      expect(assigns(:place).type).to eq('http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion')
      expect(assigns(:place).name).to eq('core#prefLabel - 1')
    end

    it 'assigns @constituencies' do
      expect(assigns(:constituencies)).to be_a(Array)
      expect(assigns(:constituencies)[0]).to be_a(Grom::Node)
      expect(assigns(:constituencies)[0].type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')
    end

    it 'assigns @constituencies in alphabetical order' do
      expect(assigns(:constituencies)[0].name).to eq('constituencyGroupName - 1')
      expect(assigns(:constituencies)[1].name).to eq('constituencyGroupName - 10')
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET a_to_z' do
    before(:each) do
      get :a_to_z, params: { place_id: 'E15000001'}
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @place' do
      expect(assigns(:place)).to be_a(Grom::Node)
      expect(assigns(:place).type).to eq('http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion')
      expect(assigns(:place).name).to eq('core#prefLabel - 1')
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'renders the a to z template' do
      expect(response).to render_template('a_to_z')
    end
  end

  describe 'GET letters' do
    before(:each) do
      get :letters, params: { place_id: 'E15000001', letter: 'd' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @place' do
      expect(assigns(:place)).to be_a(Grom::Node)
      expect(assigns(:place).type).to eq('http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion')
      expect(assigns(:place).name).to eq('core#prefLabel - 1')
    end

    it 'assigns @constituencies' do
      expect(assigns(:constituencies)).to be_a(Array)
      expect(assigns(:constituencies)[0]).to be_a(Grom::Node)
      expect(assigns(:constituencies)[0].type).to eq('http://id.ukpds.org/schema/ConstituencyGroup')
    end

    it 'assigns @constituencies in alphabetical order' do
      expect(assigns(:constituencies)[0].name).to eq('constituencyGroupName - 1')
      expect(assigns(:constituencies)[1].name).to eq('constituencyGroupName - 10')
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'renders the letters template' do
      expect(response).to render_template('letters')
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
        {
          route: 'index',
          parameters: { place_id: 'E15000001' },
          data_url: "#{ENV['PARLIAMENT_BASE_URL']}/region_constituencies?region_code=E15000001"
        },
        {
          route: 'a_to_z',
          parameters: { place_id: 'E15000001' },
          data_url: "#{ENV['PARLIAMENT_BASE_URL']}/region_constituencies_a_to_z?region_code=E15000001"
        },
        {
          route: 'letters',
          parameters: { place_id: 'E15000001', letter: 'd' },
          data_url: "#{ENV['PARLIAMENT_BASE_URL']}/region_constituencies_by_initial?region_code=E15000001&initial=d"
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
