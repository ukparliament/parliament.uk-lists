require 'rails_helper'

RSpec.describe 'houses/parties/members/a_to_z', vcr: true do
  before do
    assign(:house_id, 'KL2k1BGP')
    assign(:party_id, 'pPvA9vKP')
    @house = Class.new
    allow(@house).to receive(:name).and_return("House of Commons")
    @party = Class.new
    allow(@party).to receive(:name).and_return("Conservative")
    @current_person_type = "MPs"
    assign(:letters, 'A')
    allow(view).to receive(:house_parties_party_members_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members')
    allow(view).to receive(:house_parties_party_members_a_z_letter_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members/a-z/a')
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Conservative - Current and former MPs/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - select a letter/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(
        partial: 'pugin/components/_navigation-letter',
        locals:  { route_args: ['KL2k1BGP', 'pPvA9vKP'] }
      )
    end
  end
end
