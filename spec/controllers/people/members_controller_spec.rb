require 'rails_helper'

RSpec.describe People::MembersController, vcr: true do

  describe "GET index" do
    before(:each) do
      get :index
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @people and @letters' do
      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('https://id.parliament.uk/schema/Person')
      end

      expect(assigns(:letters)).to be_a(Array)
    end

   it 'assigns @people in alphabetical order' do
     expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
     expect(assigns(:people)[1].given_name).to eq('personGivenName - 10')
   end

   it 'renders the members template' do
     expect(response).to render_template('index')
   end
  end

  describe "GET current" do
    before(:each) do
      get :current
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @people and @letters' do
      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('https://id.parliament.uk/schema/Person')
      end

      expect(assigns(:letters)).to be_a(Array)
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
      expect(assigns(:people)[1].given_name).to eq('personGivenName - 10')
    end

    it 'renders the current_members template' do
      expect(response).to render_template('current')
    end
  end

  describe 'GET letters' do
    context 'there is a response' do
      before(:each) do
        get :letters, params: { letter: 'y' }
      end

      it 'should have a response with http status ok (200)' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @people and @letters' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('https://id.parliament.uk/schema/Person')
        end

        expect(assigns(:letters)).to be_a(Array)
      end

      it 'assigns @people in alphabetical order' do
        expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
        expect(assigns(:people)[1].given_name).to eq('personGivenName - 10')
      end

      it 'renders the members_letters template' do
        expect(response).to render_template('letters')
      end
    end

    context 'there is no response' do
      before(:each) do
        get :letters, params: { letter: 'x' }
      end

      it 'http status of 200' do
        expect(response).to have_http_status(200)
      end

      it 'has a blank @people array' do
        expect(controller.instance_variable_get(:@people)).to be_empty
      end
    end
  end

  describe "GET current_letters" do
    context 'there is a response' do
      before(:each) do
        get :current_letters, params: { letter: 'z' }
      end

      it 'should have a response with http status ok (200)' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns @people and @letters' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('https://id.parliament.uk/schema/Person')
        end

        expect(assigns(:letters)).to be_a(Array)
      end

      it 'assigns @people in alphabetical order' do
        expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
        expect(assigns(:people)[1].given_name).to eq('personGivenName - 2')
      end

      it 'renders the current_members_letters template' do
        expect(response).to render_template('current_letters')
      end
    end

    context 'there is no response' do
      before(:each) do
        get :current_letters, params: { letter: 'x' }
      end

      it 'should have a response with a http status of 200' do
        expect(response).to have_http_status(200)
      end

      it 'should have a blank @people array' do
        expect(controller.instance_variable_get(:@people)).to be_empty
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

    it 'renders the a_to_z_members template' do
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

    it 'renders the a_to_z_current_members template' do
      expect(response).to render_template('a_to_z_current')
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/member_index"
          },
          {
            route: 'current',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/member_current"
          },
          {
            route: 'letters',
            parameters: { letter: 'y' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/member_by_initial?initial=y"
          },
          {
            route: 'current_letters',
            parameters: { letter: 'z' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/member_current_by_initial?initial=z"
          },
          {
            route: 'a_to_z',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/member_a_to_z"
          },
          {
            route: 'a_to_z_current',
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/member_current_a_to_z"
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
