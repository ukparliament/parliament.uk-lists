require 'rails_helper'

RSpec.describe 'groups/government_organisations/current_letters', vcr: true do
  before do
    assign(:government_organisations, [double(:government_organisation, name: 'GroupName', graph_id: 'ziLwaBLc')])
    assign(:letters, 'C')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current Government Organisations/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - showing results for C/)
    end
  end

  context 'partials' do
    it 'will render _government_organisation_list' do
      expect(response).to render_template(partial: '_government_organisation_list')
    end
  end
end
