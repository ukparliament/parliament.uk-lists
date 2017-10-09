require 'rails_helper'

RSpec.describe People::CommitteesController, vcr: true do

  describe 'GET index' do
    before(:each) do
      get :index, params: { person_id: 'Kz7ncmrt' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @person and @committee_memberships' do
      expect(assigns(:person)).to be_a(Grom::Node)
      expect(assigns(:person).type).to eq('http://id.ukpds.org/schema/Person')

      assigns(:committee_memberships).each do |committee_membership|
        expect(committee_membership).to be_a(Grom::Node)
        expect(committee_membership.type).to eq('http://id.ukpds.org/schema/FormalBodyMembership')
      end
    end

    it 'assigns @committee_membships by start date' do
      expect(assigns(:committee_memberships)[0].start_date).to eq('2017-06-22')
      expect(assigns(:committee_memberships)[1].start_date).to eq('2015-06-30')
    end

    it 'renders the members template' do
      expect(response).to render_template('index')
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            parameters: { person_id: '7KNGxTli' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/person_committees_index?person_id=7KNGxTli"
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
