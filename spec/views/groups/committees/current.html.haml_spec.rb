require 'rails_helper'

RSpec.describe 'groups/committees/current', vcr: true do
  before do
    assign(:committees, [double(:committee, name: 'CommitteeName', graph_id: '5fgbn9kf')])
    assign(:letters, 'C')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current committees/)
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
