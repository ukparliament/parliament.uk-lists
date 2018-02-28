require 'rails_helper'

RSpec.describe 'groups/lookup_by_letters', vcr: true do
  before do
    assign(:groups, [double(:group, name: 'GroupName', graph_id: 'ziLwaBLc')])
    assign(:letters, 'C')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current and former groups/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - showing all/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render _group_list' do
      expect(response).to render_template(partial: '_group_list')
    end
  end
end
