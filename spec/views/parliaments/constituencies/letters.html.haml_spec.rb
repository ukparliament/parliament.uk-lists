require 'rails_helper'

RSpec.describe 'parliaments/constituencies/letters', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2015 to 2017', graph_id: 'd7b0ec7n'))
    assign(:all_path, :parliament_constituencies_path)
    assign(:letters, 'F')
    controller.params = { letter: 'f' }
    @constituencies = [double(:constituency,
      name: 'Test Constituency',
      graph_id: 'asdf1234',
      party: 'Labour',
      members: []
    )]
  end

  context 'header' do
    before do
      render
    end

    it 'will render the correct header' do
      expect(rendered).to match(/Constituencies/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2015 to 2017 Parliament/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/A to Z - showing results for F/)
    end
  end

  context 'partials' do
    before do
      render
    end

    it 'will render pugin/components/navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end
  end

  context 'constituencies' do
    context 'not empty' do
      before do
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
