require 'rails_helper'

RSpec.describe 'parliaments/members/letters', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2005 to 2010', graph_id: 'd7b0ec7n'))
    assign(:all_path, :parliament_members_path)
    assign(:people,
      [double(:person,
        graph_id: 'i38vttrf',
        display_name: 'Test Name',
        constituencies: [],
        seat_incumbencies: [],
        current_mp?: false
      )]
    )
    assign(:letters, 'G')
    controller.params = { letter: 'g' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/MPs/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2005 to 2010 parliament/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/A to Z - showing results for G/)
    end

    it 'will render pugin/components/_navigation-letter partial' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render pugin/elements/_list' do
      expect(response).to render_template(partial: 'pugin/elements/_list')
    end
  end
end
