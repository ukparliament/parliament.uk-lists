require 'rails_helper'

RSpec.describe 'houses/committees/letters', vcr: true do
  before do
    assign(:house, double(:house, name: 'Test House', graph_id: 'KL2k1BGP'))
    assign(:committees, [])

    assign(:house_id, 'KL2k1BGP')
    assign(:letters, 'A')
    controller.params = { letter: 'a' }

    render
  end

  context 'header' do
    it 'will render the page title' do
      expect(rendered).to match(/Current and former committees/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - showing results for A/)
    end
  end

  context 'partials' do
    it 'will render letter navigation' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render pugin/elements/_list' do
      expect(response).to render_template('pugin/elements/_list')
    end
  end
end
