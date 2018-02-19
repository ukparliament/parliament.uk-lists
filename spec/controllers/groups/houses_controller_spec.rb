require 'rails_helper'

RSpec.describe Groups::HousesController, vcr: true do
  describe 'GET index' do
    before(:each) do
      get :index, params: { group_id: 'OXwyoZdB' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @group and @houses' do
      expect(assigns(:group)).to be_a(Grom::Node)
      expect(assigns(:group).type).to eq('https://id.parliament.uk/schema/Group')

      assigns(:houses).each do |house|
        expect(house).to be_a(Grom::Node)
        expect(house.type).to eq('https://id.parliament.uk/schema/House')
        expect(house.name).to eq('houseName - 1')

      end
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
            parameters: { group_id: 'OXwyoZdB'},
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_houses_index?group_id=OXwyoZdB"
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
