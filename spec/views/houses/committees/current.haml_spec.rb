require 'rails_helper'

RSpec.describe 'houses/committees/current', vcr: true do
  before do
    allow(Parliament::Utils::Helpers::HousesHelper).to receive(:commons?).and_return(true)
    allow(Parliament::Utils::Helpers::FlagHelper).to receive(:dissolution?).and_return(true)

    assign(:house, double(:house, name: 'Test House', graph_id: 'KL2k1BGP'))
    assign(:committees, [])

    assign(:house_id, 'KL2k1BGP')
    assign(:letters, 'A')
    controller.params = { letter: 'a' }

    render
  end

  context 'header' do
    it 'will render the current type' do
      expect(rendered).to match(/Current Committees/)
    end
  end

  context 'partials' do
    it 'will render letter navigation' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render pugin/elements/_list' do
      expect(response).to render_template('pugin/elements/_list')
    end

    it 'will render dissolution message' do
      expect(response).to render_template(partial: 'shared/_dissolution_message')
    end
  end
end
