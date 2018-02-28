require 'rails_helper'

RSpec.describe Groups::GovernmentOrganisationsController, vcr: true do
  describe 'GET index' do
    before(:each) do
      get :index
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @government_organisations and @letters' do
      assigns(:government_organisations).each do |government_organisation|
        expect(government_organisation).to be_a(Grom::Node)
        expect(government_organisation.type).to eq('https://id.parliament.uk/schema/GovRegisterGovernmentOrganisation')
      end

      expect(assigns(:letters)).to be_a(Array)
    end

    it 'assigns @government_organisations in alphabetical order' do
      expect(assigns(:government_organisations)[0].name).to eq('groupName - 1')
      expect(assigns(:government_organisations)[3].name).to eq('groupName - 10')
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET current' do
    before(:each) do
      get :current
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'should return the current number of government_organisations' do
      expect(assigns(:government_organisations).size).to eq(26)
    end

    it 'assigns @government_organisations and @letters' do
      assigns(:government_organisations).each do |government_organisation|
        expect(government_organisation).to be_a(Grom::Node)
        expect(government_organisation.type).to eq('https://id.parliament.uk/schema/GovRegisterGovernmentOrganisation')
      end

      expect(assigns(:letters)).to be_a(Array)
    end

    it 'assigns @government_organisations in alphabetical order' do
      expect(assigns(:government_organisations)[0].name).to eq('groupName - 1')
      expect(assigns(:government_organisations)[1].name).to eq('groupName - 10')
    end

    it 'renders the current template' do
      expect(response).to render_template('current')
    end
  end

  describe 'GET letters' do
    context 'valid government_organisations' do
      before(:each) do
        get :letters, params: { letter: 'd' }
      end

      it 'should have a response with http status ok (200)' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @government_organisations and @letters' do
        assigns(:government_organisations).each do |government_organisation|
          expect(government_organisation).to be_a(Grom::Node)
          expect(government_organisation.type).to eq('https://id.parliament.uk/schema/GovRegisterGovernmentOrganisation')
        end

        expect(assigns(:letters)).to be_a(Array)
      end

      it 'assigns @government_organisations in alphabetical order' do
        expect(assigns(:government_organisations)[0].name).to eq('groupName - 1')
        expect(assigns(:government_organisations)[1].name).to eq('groupName - 10')
      end

      it 'renders the letters template' do
        expect(response).to render_template('letters')
      end
    end

    context 'invalid government_organisations' do
      before(:each) do
        get :letters, params: { letter: 'x' }
      end

      it 'should return a 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should populate @government_organisations with an empty array' do
        expect(controller.instance_variable_get(:@government_organisations)).to be_empty
      end
    end
  end

  describe 'GET current_letters' do
    context 'valid government_organisations' do
      before(:each) do
        get :current_letters, params: { letter: 'd' }
      end

      it 'should have a response with http status ok (200)' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @government_organisations and @letters' do
        assigns(:government_organisations).each do |government_organisation|
          expect(government_organisation).to be_a(Grom::Node)
          expect(government_organisation.type).to eq('https://id.parliament.uk/schema/GovRegisterGovernmentOrganisation')
        end

        expect(assigns(:letters)).to be_a(Array)
      end

      it 'assigns @government_organisations in alphabetical order' do
        expect(assigns(:government_organisations)[0].name).to eq('groupName - 13')
        expect(assigns(:government_organisations)[1].name).to eq('groupName - 14')
      end

      it 'renders the current_letters template' do
        expect(response).to render_template('current_letters')
      end
    end

    context 'invalid government_organisations' do
      before(:each) do
        get :letters, params: { letter: 'x' }
      end

      it 'should return a 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'should populate @government_organisations with an empty array' do
        expect(controller.instance_variable_get(:@government_organisations)).to be_empty
      end
    end
  end

  describe "GET a_to_z" do
    before(:each) do
      get :a_to_z
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'renders the a_to_z template' do
      expect(response).to render_template('a_to_z')
    end
  end

  describe "GET a_to_z_current" do
    before(:each) do
      get :a_to_z_current
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'renders the a_to_z template' do
      expect(response).to render_template('a_to_z_current')
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_government_organisation_index"
          },
          {
            route: 'current',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_government_organisation_current"
          },
          {
            route: 'letters',
            parameters: { letter: 'l' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_government_organisation_by_initial?initial=l"
          },
          {
            route: 'current_letters',
            parameters: { letter: 'l' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_government_organisation_current_by_initial?initial=l"
          },
          {
            route: 'a_to_z',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_government_organisation_a_to_z"
          },
          {
            route: 'a_to_z_current',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_government_organisation_current_a_to_z"
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
