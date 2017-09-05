require 'rails_helper'

RSpec.describe 'places/constituencies/letters', vcr: true do
  before do
    assign(:place, double(:place, name: 'North East', gss_code: 'E15000001'))
    assign(:constituencies, [])
    assign(:letters, 'A')
    controller.params = { letter: 'a' }

    render
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render pugin/elements/_list' do
      expect(response).to render_template('pugin/elements/_list')
    end
  end
end
