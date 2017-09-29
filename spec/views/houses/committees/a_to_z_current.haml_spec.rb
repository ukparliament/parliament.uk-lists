require 'rails_helper'

RSpec.describe 'houses/committees/a_to_z_current', vcr: true do
  before do
    assign(:house, double(:house, name: 'Test House', graph_id: 'KL2k1BGP'))
    assign(:committees, [])

    assign(:house_id, 'KL2k1BGP')
    assign(:letters, 'A')

    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current committees/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - select a letter/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter', locals: { route_args: ['KL2k1BGP'] })
    end
  end
end
