require 'rails_helper'

RSpec.describe 'groups/memberships/a_to_z', vcr: true do
  before do
    assign(:group,
      double(:group,
        graph_id: 'tWzrJATE',
        name:     'Test Group Name'))
    assign(:letters, ['a'])
    assign(:all_path, :group_memberships_path)
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current and former committee members - Test Group Name/)
    end
  end

  context 'navigation letters' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end
  end
end
