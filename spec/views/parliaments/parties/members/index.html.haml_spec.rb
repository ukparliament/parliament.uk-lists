require 'rails_helper'

RSpec.describe 'parliaments/parties/members/index', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2010 to 2015', graph_id: 'd7b0ec7n'))
    assign(:party, double(:party, name: 'Labour', graph_id: 'b6tdch4k'))
    assign(:letters, [])
    assign(:people,
      [double(:person,
        graph_id: 'i38vttrf',
        display_name: 'Test Name',
        constituencies: [],
        seat_incumbencies: [],
        current_mp?: false
      )]
    )
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Labour - MPs and Lords/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2010 to 2015 Parliament/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/A to Z - showing all/)
    end

    it 'will render pugin/components/_navigation-letter partial' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end
  end

  context '@people' do
    it 'will render pugin/elements/_list partial' do
      expect(response).to render_template(partial: 'pugin/elements/_list')
    end
  end

end
