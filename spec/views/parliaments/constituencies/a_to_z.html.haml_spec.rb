require 'rails_helper'

RSpec.describe 'parliaments/constituencies/a_to_z', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2015 to 2017', graph_id: 'd7b0ec7n'))
    assign(:letters, [])
    assign(:all_path, :parliament_constituencies_path)
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Constituencies/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2015 to 2017 parliament/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/A to Z - select a letter/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end
  end

end
