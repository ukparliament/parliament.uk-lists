require 'rails_helper'

RSpec.describe People::Questions::WrittenController, vcr: true do
  describe 'GET index' do
    before(:each) do
      get :index, params: { person_id: 'Niiic8ma' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @asking_person, @questions and @questions_grouped_by_date' do
      expect(assigns(:asking_person)).to be_a(Grom::Node)
      expect(assigns(:asking_person).type).to eq('https://id.parliament.uk/schema/Person')

      assigns(:questions).each do |question|
        expect(question).to be_a(Grom::Node)
        expect(question.type).to eq('https://id.parliament.uk/schema/Question')
      end

      assigns(:questions_grouped_by_date).each do |date, questions|
        expect(date).to be_a(Date)
        expect(questions.first.type).to eq('https://id.parliament.uk/schema/Question')
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
            parameters: { person_id: '7KNGxTli' },
            data_url: "#{ENV['PARLIAMENT_BASE_URL']}/person_questions_written?person_id=7KNGxTli"
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
