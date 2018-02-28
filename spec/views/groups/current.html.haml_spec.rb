require 'rails_helper'

RSpec.describe 'groups/current', vcr: true do
  before do
    assign(:groups, [])
    assign(:letters, 'C')
    assign(:group_id, 'ziLwaBLc')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current groups/)
    end
  end

  context 'partials' do
    it 'will render _group_list' do
      expect(response).to render_template(partial: '_group_list')
    end
  end
end
