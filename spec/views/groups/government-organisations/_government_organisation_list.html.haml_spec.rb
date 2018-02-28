require 'rails_helper'

RSpec.describe 'groups/government_organisations/_government_organisation_list', vcr: true do
  context '@government_organisations is empty' do
    before do
      assign(:government_organisations, [])
      controller.params = { letter: 'a' }
      render
    end

    context 'partials' do
      it 'will render shared/_empty_list' do
        expect(response).to render_template(partial: 'shared/_empty_list')
      end
    end
  end

  context '@government_organisations is not empty' do
    before do
      assign(:government_organisations, [double(:government_organisation, name: 'governmentOrganisationName', graph_id: 'ziLwaBLc')])
      render
    end

    context 'links' do
      it 'will link to government_organisation_path' do
        expect(rendered).to have_link('governmentOrganisationName', href: group_path('ziLwaBLc'))
      end
    end
  end
end
