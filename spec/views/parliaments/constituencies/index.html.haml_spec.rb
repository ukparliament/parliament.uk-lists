require 'rails_helper'

RSpec.describe 'parliaments/constituencies/index', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2015 to 2017', graph_id: 'd7b0ec7n'))
    assign(:letters, [])
  end

  context 'header' do
    before do
      assign(:constituencies, [])
      render
    end

    it 'will render the correct header' do
      expect(rendered).to match(/Constituencies/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2015 to 2017 Parliament/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/A to Z - showing all/)
    end

  end

  context '@constituencies' do
    context 'not empty' do
      before do
        @constituencies = [double(:constituency,
          name: 'Test Constituency',
          graph_id: 'asdf1234',
          party: 'Labour',
          members: []
        )]
        render
      end

      it 'will render constituencies/list' do
        expect(response).to render_template(partial: 'pugin/constituencies/list/_list')
      end
    end

    context 'empty' do
      before do
        @constituencies = []
        render
      end

      it 'will not render constituencies/list' do
        expect(response).not_to render_template(partial: 'pugin/constituencies/list/_list')
      end
    end
  end
end
