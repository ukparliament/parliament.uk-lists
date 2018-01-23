require 'rails_helper'

RSpec.describe 'parliaments/houses/index', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2015 to 2017', graph_id: 'd7b0ec7n'))
    assign(:houses, [
      double(:house, name: 'House of Commons', graph_id: 'zxcv9786'),
      double(:house, name: 'House of Lords', graph_id: 'ivr78xfg')
    ])
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Houses/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2015 to 2017 Parliament/)
    end
  end

  context 'houses' do
    it 'will show the name of each house' do
      expect(rendered).to match(/House of Commons/)
      expect(rendered).to match(/House of Lords/)
    end
  end

end
