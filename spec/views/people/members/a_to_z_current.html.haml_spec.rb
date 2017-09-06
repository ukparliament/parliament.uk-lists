require 'rails_helper'

RSpec.describe 'people/members/a_to_z_current', vcr: true do
  before do
    assign(:letters, 'A')
    assign(:person_id, 'jF43Jxoc')
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current MPs and Lords/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - select a letter/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end
  end
end
