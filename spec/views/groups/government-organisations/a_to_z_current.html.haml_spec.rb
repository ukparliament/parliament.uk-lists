require 'rails_helper'

RSpec.describe 'groups/government_organisations/a_to_z_current', vcr: true do
  before do
    assign(:government_organisations, [double(:government_organisation, name: 'GovernmentOrganisationName', graph_id: 'ziLwaBLc')])
    assign(:letters, 'C')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current Government Organisations/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - select a letter/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter', locals: { route_symbol: :groups_government_organisations_current_a_z_letter_path, all_path: @all_path })
    end
  end
end
