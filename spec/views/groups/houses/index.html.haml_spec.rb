require 'rails_helper'

RSpec.describe 'groups/houses/index', vcr: true do
  before do
    assign(:group, double(:group, name: 'GroupName', graph_id: 'ziLwaBLc'))
    assign(:houses, [double(:house, name: 'House of Commons', graph_id: 'KL2k1BGP')])
    assign(:letters, 'C')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/GroupName houses/)
    end
  end

  context 'houses' do
    it 'will render correct house name' do
      expect(rendered).to match(/House of Commons/)
    end
  end
end
