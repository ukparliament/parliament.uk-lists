require 'rails_helper'

RSpec.describe 'groups/committees/a_to_z', vcr: true do
  before do
    assign(:letters, 'C')
    controller.params = { letter: 'c' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current and former committees/)
    end

    it 'will render the correct sub-header' do
      expect(rendered).to match(/A to Z - select a letter/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter', locals: { route_symbol: :groups_committees_a_z_letter_path, all_path: @all_path })
    end
  end
end
