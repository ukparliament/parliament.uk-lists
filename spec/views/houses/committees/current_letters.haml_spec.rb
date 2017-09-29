require 'rails_helper'

RSpec.describe 'houses/committees/current_letters', vcr: true do

  describe 'no dissolution' do
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
      it 'will render the current person type' do
        expect(rendered).to match(/Current committees/)
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

      context 'with bandiera dissolution flag set' do
        it 'will render dissolution message' do
          expect(response).to render_template(partial: 'shared/_dissolution_message')
        end
      end
    end
  end

  describe 'dissolution messaging' do
    before do
      allow(Parliament::Utils::Helpers::FlagHelper).to receive(:dissolution?).and_return(false)
      assign(:house, double(:house, name: 'Test House', graph_id: 'KL2k1BGP'))
      assign(:committees, [])

      assign(:house_id, 'KL2k1BGP')
      assign(:letters, 'A')
      controller.params = { letter: 'a' }

      render
    end

    it 'will not render dissolution message' do
      expect(response).not_to render_template(partial: 'shared/_dissolution_message')
    end
  end

end
