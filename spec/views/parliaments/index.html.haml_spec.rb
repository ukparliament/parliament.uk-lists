require 'rails_helper'

RSpec.describe 'parliaments/index', vcr: true do
  before do
    assign(:parliaments,
      [
        double(:parliament, graph_id: 'i38vttrf', date_range: '2017 to present'),
        double(:parliament, graph_id: 'fghjkltb', date_range: '2015 to 2017'),
        double(:parliament, graph_id: '457nfdch', date_range: '2010 to 2015'),
      ]
    )
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Parliaments/)
    end
  end

  context '@parliaments' do
    it 'will show each parliament' do
      expect(rendered).to match(/2017 to present/)
      expect(rendered).to match(/2015 to 2017/)
      expect(rendered).to match(/2010 to 2015/)
    end
  end

end
