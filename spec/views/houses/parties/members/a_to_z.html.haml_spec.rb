require 'rails_helper'

RSpec.describe 'houses/parties/members/a_to_z', vcr: true do
  before do
    assign(:house_id, 'KL2k1BGP')
    assign(:party_id, 'pPvA9vKP')
    assign(:letters, 'A')
    allow(view).to receive(:house_parties_party_members_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members')
    allow(view).to receive(:house_parties_party_members_a_z_letter_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members/a-z/a')
    render
  end

  it 'will render pugin/components/_navigation-letter' do
    expect(response).to render_template(
      partial: 'pugin/components/_navigation-letter',
      locals:  { route_args: ['KL2k1BGP', 'pPvA9vKP'] }
    )
  end
end
