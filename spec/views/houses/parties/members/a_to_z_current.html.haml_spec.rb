require 'rails_helper'

RSpec.describe 'houses/parties/members/a_to_z_current', vcr: true do
  before do
    assign(:house_id, 'KL2k1BGP')
    assign(:party_id, 'pPvA9vKP')
    assign(:letters, 'A')
    allow(view).to receive(:house_parties_party_members_current_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members/current')
    allow(view).to receive(:house_parties_party_members_current_a_z_letter_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members/current/a-z/a')
    render
  end

  it 'will render pugin/components/_navigation-letter' do
    expect(response).to render_template(
      partial: 'pugin/components/_navigation-letter',
      locals:  { route_args: ['KL2k1BGP', 'pPvA9vKP'] }
    )
  end
end
