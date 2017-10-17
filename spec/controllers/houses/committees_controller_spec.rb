require 'rails_helper'

RSpec.describe Houses::CommitteesController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index, params: { house_id: 'Kz7ncmrt' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @house, @committees and @letters' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('https://id.parliament.uk/schema/House')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:committees).each do |committee|
        expect(committee).to be_a(Grom::Node)
        expect(committee.type).to eq('https://id.parliament.uk/schema/FormalBody')
      end
    end

    it 'assigns @committees in alphabetical order' do
      expect(assigns(:committees)[0].name).to eq('formalBodyName - 1')
      expect(assigns(:committees)[1].name).to eq('formalBodyName - 10')
    end

    it 'renders the members template' do
      expect(response).to render_template('index')
    end
  end

  describe "GET current" do
    before(:each) do
      get :current, params: { house_id: 'Kz7ncmrt' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @house, @committees and @letters' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('https://id.parliament.uk/schema/House')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:committees).each do |committee|
        expect(committee).to be_a(Grom::Node)
        expect(committee.type).to eq('https://id.parliament.uk/schema/FormalBody')
      end
    end

    it 'assigns @committees in alphabetical order' do
      expect(assigns(:committees)[0].name).to eq('formalBodyName - 1')
      expect(assigns(:committees)[1].name).to eq('formalBodyName - 10')
    end

    it 'renders the current_members template' do
      expect(response).to render_template('current')
    end
  end

  describe "GET letters" do
    before(:each) do
      get :letters, params: { house_id: 'Kz7ncmrt', letter: 'a' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @house, @committees and @letters' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('https://id.parliament.uk/schema/House')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:committees).each do |committee|
        expect(committee).to be_a(Grom::Node)
        expect(committee.type).to eq('https://id.parliament.uk/schema/FormalBody')
      end
    end

    it 'assigns @committees in alphabetical order' do
      expect(assigns(:committees)[0].name).to eq('formalBodyName - 1')
      expect(assigns(:committees)[1].name).to eq('formalBodyName - 101')
    end

    it 'renders the members_letters template' do
      expect(response).to render_template('letters')
    end
  end

  describe "GET current_letters" do
    before(:each) do
      get :current_letters, params: { house_id: 'Kz7ncmrt', letter: 'a' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @house, @committees and @letters' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('https://id.parliament.uk/schema/House')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:committees).each do |committee|
        expect(committee).to be_a(Grom::Node)
        expect(committee.type).to eq('https://id.parliament.uk/schema/FormalBody')
      end
    end

    it 'assigns @committees in alphabetical order' do
      expect(assigns(:committees)[0].name).to eq('formalBodyName - 1')
      expect(assigns(:committees)[1].name).to eq('formalBodyName - 2')
    end

    it 'renders the current_members_letters template' do
      expect(response).to render_template('current_letters')
    end
  end

  describe "GET a_to_z" do
    before(:each) do
      get :a_to_z, params: { house_id: 'Kz7ncmrt' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'assigns @house' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('https://id.parliament.uk/schema/House')
    end

    it 'renders the a_to_z_members template' do
      expect(response).to render_template('a_to_z')
    end
  end

  describe "GET a_to_z_current" do
    before(:each) do
      get :a_to_z_current, params: { house_id: 'Kz7ncmrt' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'assigns @house' do
      expect(assigns(:house)).to be_a(Grom::Node)
      expect(assigns(:house).type).to eq('https://id.parliament.uk/schema/House')
    end

    it 'renders the a_to_z_current_members template' do
      expect(response).to render_template('a_to_z_current')
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            parameters: { house_id: 'Kz7ncmrt' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/house_committees_index?house_id=Kz7ncmrt"
          },
          {
            route: 'a_to_z_current',
            parameters: { house_id: 'Kz7ncmrt' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/house_current_committees_a_to_z?house_id=Kz7ncmrt"
          },
          {
            route: 'current',
            parameters: { house_id: 'Kz7ncmrt' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/house_current_committees?house_id=Kz7ncmrt"
          },
          {
            route: 'letters',
            parameters: { house_id: 'Kz7ncmrt', letter: 'p' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/house_committees_by_initial?house_id=Kz7ncmrt&initial=p"
          },
          {
            route: 'current_letters',
            parameters: { house_id: 'Kz7ncmrt', letter: 'p' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/house_current_committees_by_initial?house_id=Kz7ncmrt&initial=p"
          },
          {
            route: 'a_to_z',
            parameters: { house_id: 'Kz7ncmrt' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/house_committees_a_to_z?house_id=Kz7ncmrt"
          },
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
