require 'rails_helper'

RSpec.describe People::Associations::GroupedBy::FormalBodiesController, vcr: true do
  describe "GET index" do
    before(:each) do
      get :index, params: { person_id: '1CRqwuTp' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @person, @seat_incumbencies, @committee_memberships, @current_party_membership,
    @most_recent_incumbency and @current_incumbency' do
      expect(assigns(:person)).to be_a(Grom::Node)
      expect(assigns(:person).type).to eq('https://id.parliament.uk/schema/Person')

      assigns(:seat_incumbencies).each do |seat_incumbency|
        expect(seat_incumbency).to be_a(Grom::Node)
        expect(seat_incumbency.type).to eq('https://id.parliament.uk/schema/SeatIncumbency')
      end

      assigns(:committee_memberships).each do |committee_membership|
        expect(committee_membership).to be_a(Grom::Node)
        expect(committee_membership.type).to eq('https://id.parliament.uk/schema/FormalBodyMembership')
      end
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'adds committee memberships to history' do
      history = controller.instance_variable_get(:@history)
      count = 0
      history[:years].keys.each { |year| count = count + history[:years][year].length }
      expect(count).to eq(2)
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            parameters: { person_id: '7KNGxTli' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/person_associations_grouped_by_formal_bodies?person_id=7KNGxTli"
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
