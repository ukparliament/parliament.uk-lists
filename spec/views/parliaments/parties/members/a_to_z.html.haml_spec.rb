require 'rails_helper'

RSpec.describe 'parliaments/parties/members/a_to_z', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2015 to 2017', graph_id: 'd7b0ec7n'))
    assign(:party, double(:party, name: 'Green Party', graph_id: 'b6tdch4k'))
    assign(:letters, [])
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Green Party - MPs and Lords/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2015 to 2017 parliament/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/A to Z - select a letter/)
    end

    it 'will render pugin/components/_navigation-letter partial' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end
  end
end
