require 'rails_helper'

RSpec.describe ParliamentsController, vcr: true do
  describe "GET index" do
    before(:each) do
      get :index
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @parliaments' do
      assigns(:parliaments).each do |parliament|
        expect(parliament).to be_a(Grom::Node)
        expect(parliament.type).to eq('http://id.ukpds.org/schema/ParliamentPeriod')
      end
    end

    it 'assigns @parliaments in numeric order' do
      expect(assigns(:parliaments)[0].number).to eq(57)
      expect(assigns(:parliaments)[1].number).to eq(56)
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
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/parliaments"
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
    describe 'next' do
      context '@parliament is nil' do
        # updated VCR cassette in order to set @parliament to nil
        it 'should raise ActionController::RoutingError' do
          expect{get :next}.to raise_error(ActionController::RoutingError)
        end
      end

      context '@parliament is not nil' do
        before(:each) do
          headers = { 'Accept' => 'application/rdf+xml' }
          request.headers.merge(headers)
          get :next
        end

        it 'should have a response with http status redirect (302)' do
            expect(response).to have_http_status(302)
        end

        it 'redirects to the data service' do
            expect(response).to redirect_to("#{ENV['PARLIAMENT_BASE_URL']}/parliaments/next")
        end
      end
    end
  end
end
