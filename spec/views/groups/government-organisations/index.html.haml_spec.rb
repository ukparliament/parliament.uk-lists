require 'rails_helper'

RSpec.describe 'groups/government_organisations/index', vcr: true do
  before do
    assign(:government_organisations, [double(:government_organisation, name: 'GroupName', graph_id: 'ziLwaBLc')])
    assign(:letters, 'C')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current and former Government Organisations/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render _government_organisation_list' do
      expect(response).to render_template(partial: '_government_organisation_list')
    end
  end
end
