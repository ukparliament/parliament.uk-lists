require 'rails_helper'

RSpec.describe 'parliaments/parties/members/letters', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2015 to 2017', graph_id: 'd7b0ec7n'))
    assign(:party, double(:party, name: 'Conservative', graph_id: 'b6tdch4k'))
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
    assign(:letters, 'P')
    controller.params = { letter: 'p' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Conservative - MPs and Lords/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2015 to 2017 Parliament/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/A to Z - showing results for P/)
    end

    it 'will render pugin/components/_navigation-letter partial' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render pugin/elements/_list partial' do
      expect(response).to render_template(partial: 'pugin/elements/_list')
    end
  end

end
