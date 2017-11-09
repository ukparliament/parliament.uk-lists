require 'rails_helper'

RSpec.describe 'houses/parties/members/letters', vcr: true do
  before do
    assign(:house, double(:house, name: 'House of Commons', graph_id: 'KL2k1BGP'))
    assign(:party, double(:party, name: 'Conservative', graph_id: 'jF43Jxoc', member_count: 10))
    assign(:people, [])
    assign(:current_person_type, 'MPs')
    assign(:letters, 'A')
    assign(:all_path, :house_parties_party_members_path)
    allow(view).to receive(:house_parties_party_members_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members')
    allow(view).to receive(:house_parties_party_members_a_z_letter_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members/a-z/a')

    controller.params = { letter: 'a' }
    allow(view).to receive(:house_parties_party_members_path).and_return("/houses/Kz7ncmrt/parties/AJgeHzL2/members")

    render
  end

  context 'header' do
    it 'will render the page title' do
      expect(rendered).to match(/Conservative - Current and former MPs/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - showing results for A/)
    end
  end

  context 'partials' do
    it 'will render letter navigation' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
      expect(rendered).to include('<a href="/houses/Kz7ncmrt/parties/AJgeHzL2/members">All</a>')
    end

    it 'will render pugin/elements/_list' do
      expect(response).to render_template('pugin/elements/_list')
    end
  end
end
