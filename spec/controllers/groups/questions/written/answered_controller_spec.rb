require 'rails_helper'

RSpec.describe Groups::Questions::Written::AnsweredController, vcr: true do
  describe 'GET index' do
    before(:each) do
      get :index, params: { group_id: 'fpWTqVKh'}
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @answering_body, @answers and @answers_grouped_by_date' do
      expect(assigns(:answering_body).type).to eq('https://id.parliament.uk/schema/AnsweringBody')

      assigns(:answers).each do |answer|
        expect(answer.type).to eq('https://id.parliament.uk/schema/Answer')
      end

      expect(assigns(:answers_grouped_by_date).keys.first).to be_a(Date)

      expect(assigns(:answers_grouped_by_date).values.first.first.type).to eq('https://id.parliament.uk/schema/Answer')
    end

    context 'the answer does not have a date' do
      it 'assigns assigns @answering_body, @answers and @answers_grouped_by_date' do
        expect(assigns(:answering_body).type).to eq('https://id.parliament.uk/schema/AnsweringBody')

        assigns(:answers).each do |answer|
          expect(answer.type).to eq('https://id.parliament.uk/schema/Answer')
        end

        expect(assigns(:answers_grouped_by_date).keys.first).to eq(nil)

        expect(assigns(:answers_grouped_by_date).values.first.first.type).to eq('https://id.parliament.uk/schema/Answer')
      end
    end

    xit 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
