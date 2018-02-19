require 'rails_helper'

RSpec.describe Groups::PositionsController, vcr: true do
  describe 'GET index' do
    before(:each) do
      get :index, params: { group_id: 'ziLwaBLc' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @group and @positions' do
      expect(assigns(:group)).to be_a(Grom::Node)
      expect(assigns(:group).type).to eq('https://id.parliament.uk/schema/Group')

      assigns(:positions).each do |position|
        expect(position).to be_a(Grom::Node)
        expect(position.type).to eq('https://id.parliament.uk/schema/Position')
      end
    end

    it 'assigns @positions in alphabetical order' do
      expect(assigns(:positions)[0].name).to eq('positionName - 1')
      expect(assigns(:positions)[3].name).to eq('positionName - 12')
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET current' do
    before(:each) do
      get :current, params: { group_id: 'wZVxomZk' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'should return the current number of positions' do
      expect(assigns(:positions).size).to eq(1)
    end

    it 'assigns @group and @positions' do
      expect(assigns(:group)).to be_a(Grom::Node)
      expect(assigns(:group).type).to eq('https://id.parliament.uk/schema/Group')

      assigns(:positions).each do |position|
        expect(position).to be_a(Grom::Node)
        expect(position.type).to eq('https://id.parliament.uk/schema/Position')
      end
    end


    it 'assigns @positions in alphabetical order' do
      expect(assigns(:positions)[0].name).to eq('Chair')
    end

    it 'renders the current template' do
      expect(response).to render_template('current')
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
          {
            route: 'index',
            parameters: { group_id: 'ziLwaBLc'},
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_positions_index?group_id=ziLwaBLc"
          },
          {
            route: 'current',
            parameters: { group_id: 'wZVxomZk'},
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/group_positions_current?group_id=wZVxomZk"
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
