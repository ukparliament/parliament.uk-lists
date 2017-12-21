require 'rails_helper'

RSpec.describe Parties::MembersController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index, params: { party_id: 'LEYIBvV9' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('https://id.parliament.uk/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('https://id.parliament.uk/schema/Person')
      end
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].given_name).to eq('personGivenName - 1')
      expect(assigns(:people)[1].given_name).to eq('personGivenName - 10')
    end

    it 'renders the members template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET current' do
    before(:each) do
      get :current, params: { party_id: 'LEYIBvV9' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('https://id.parliament.uk/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('https://id.parliament.uk/schema/Person')
      end
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
    before(:each) do
      get :letters, params: { party_id: 'LEYIBvV9', letter: 'f' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('https://id.parliament.uk/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('https://id.parliament.uk/schema/Person')
      end
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 1')
      expect(assigns(:people)[1].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 10')
    end

    it 'renders the members_letters template' do
      expect(response).to render_template('letters')
    end
  end

  describe 'GET current_letters' do
    before(:each) do
      get :current_letters, params: { party_id: 'LEYIBvV9', letter: 'f' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @party, @people and @letters' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('https://id.parliament.uk/schema/Party')
      expect(assigns(:letters)).to be_a(Array)

      assigns(:people).each do |person|
        expect(person).to be_a(Grom::Node)
        expect(person.type).to eq('https://id.parliament.uk/schema/Person')
      end
    end

    it 'assigns @people in alphabetical order' do
      expect(assigns(:people)[0].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 1')
      expect(assigns(:people)[1].sort_name).to eq('A5EE13ABE03C4D3A8F1A274F57097B6C - 10')
    end

    it 'renders the current_members_letters template' do
      expect(response).to render_template('current_letters')
    end
  end

  describe "GET a_to_z" do
    before(:each) do
      get :a_to_z, params: { party_id: '891w1b1k' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'assigns @party' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('https://id.parliament.uk/schema/Party')
    end

    it 'renders the a_to_z_members template' do
      expect(response).to render_template('a_to_z')
    end
  end

  describe "GET a_to_z_current" do
    before(:each) do
      get :a_to_z_current, params: { party_id: '891w1b1k' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @letters' do
      expect(assigns(:letters)).to be_a(Array)
    end

    it 'assigns @party' do
      expect(assigns(:party)).to be_a(Grom::Node)
      expect(assigns(:party).type).to eq('https://id.parliament.uk/schema/Party')
    end

    it 'renders the a_to_z_current_members template' do
      expect(response).to render_template('a_to_z_current')
    end
  end

  # Test for ApplicationController Parliament::NoContentResponseError handling
  describe 'rescue_from Parliament::ClientError' do
    it 'raises an ActionController::RoutingError' do
      expect{ get :index, params: { party_id: '12345678' } }.to raise_error(ActionController::RoutingError)
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            parameters: { party_id: '891w1b1k' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/party_members?party_id=891w1b1k"
          },
          {
            route: 'current',
            parameters: { party_id: '891w1b1k' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/party_current_members?party_id=891w1b1k"
          },
          {
            route: 'letters',
            parameters: { party_id: '891w1b1k', letter: 'f' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/party_members_by_initial?party_id=891w1b1k&initial=f"
          },
          {
            route: 'current_letters',
            parameters: { party_id: '891w1b1k', letter: 'f' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/party_current_members_by_initial?party_id=891w1b1k&initial=f"
          },
          {
            route: 'a_to_z',
            parameters: { party_id: '891w1b1k' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/party_members_a_to_z?party_id=891w1b1k"
          },
          {
            route: 'a_to_z_current',
            parameters: { party_id: '891w1b1k' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/party_current_members_a_to_z?party_id=891w1b1k"
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
