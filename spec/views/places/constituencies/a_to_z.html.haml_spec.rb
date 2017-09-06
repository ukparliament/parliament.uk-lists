require 'rails_helper'

RSpec.describe 'places/constituencies/a_to_z', vcr: true do
  before do
    assign(:place, double(:place, name: 'North East', gss_code: 'E15000001'))
    assign(:letters, 'A')

    render
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end
  end
end
