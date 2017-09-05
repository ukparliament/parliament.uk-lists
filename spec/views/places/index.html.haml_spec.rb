require 'rails_helper'

RSpec.describe 'places/index', vcr: true do
  before do
    assign(:places, [double(:place, name: 'North East', gss_code: 'E15000001', constituency_count: '29')])

    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Places/)
    end
  end

  context 'links' do
    it 'will render house_path' do
      expect(rendered).to have_link('North East', href: places_show_path('E15000001'))
    end
  end

  context '@places is not nill' do
    it 'will render place name' do
      expect(rendered).to match(/North East/)
    end

    it 'will render gss code' do
      expect(rendered).to match(/E15000001/)
    end

    it 'will render constituency count' do
      expect(rendered).to match(/29/)
    end
  end
end

