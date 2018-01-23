require 'rails_helper'

RSpec.describe 'parliaments/houses/parties/index', vcr: true do
  before do
    assign(:parliament, double(:parliament, date_range: '2015 to 2017', graph_id: 'd7b0ec7n'))
    assign(:house, double(:house, graph_id: 'g88dhmvd'))
    assign(:parties, [
      double(:party, name: 'Conservative', graph_id: 'zxcv9786', member_count: 333),
      double(:party, name: 'Labour', graph_id: 'ivr78xfg', member_count: 240),
      double(:party, name: 'Scottish National Party', graph_id: 'g567dbds', member_count: 56)
    ])
    allow(Parliament::Utils::Helpers::HousesHelper).to receive(:commons?).and_return(true)
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Parties/)
    end

    it 'will render the correct date range' do
      expect(rendered).to match(/2015 to 2017 parliament/)
    end
  end

  context 'houses' do
    it 'will show the name of each party' do
      expect(rendered).to match(/Conservative/)
      expect(rendered).to match(/Labour/)
      expect(rendered).to match(/Scottish National Party/)
    end

    it 'will show the member count of each party' do
      expect(rendered).to match(/333/)
      expect(rendered).to match(/240/)
      expect(rendered).to match(/56/)
    end

    context 'MPs' do
      it 'will show count of MPs' do
        expect(rendered).to match(/MPs/)
      end
    end

    context 'Lords' do
      before do
        allow(Parliament::Utils::Helpers::HousesHelper).to receive(:commons?).and_return(false)
        render
      end

      it 'will show count of Lords' do
        expect(rendered).to match(/Lords/)
      end
    end
  end

end
