require 'rails_helper'

RSpec.describe 'groups/_group_list', vcr: true do
  let(:groups) {
    assign(:groups, [])
  }

  before(:each) do
    controller.params = { letter: 'a' }
    render 'groups/group_list', groups: groups
  end

  context 'groups is empty' do
    context 'partials' do
      it 'will render shared/_empty_list' do
        expect(response).to render_template(partial: 'shared/_empty_list')
      end
    end
  end

  context 'groups is not empty' do
    let(:groups) {
      assign(:groups, [double(:group, name: 'GroupName', graph_id: 'ziLwaBLc')])
    }

    context 'links' do
      it 'will link to group_path' do
        expect(rendered).to have_link('GroupName', href: group_path('ziLwaBLc'))
      end
    end
  end
end
