require 'rails_helper'

RSpec.describe 'people/committees/memberships/index', vcr: true do
  before do
    assign(:person, double(:person, display_name: 'Test Name'))
    assign(:committee_memberships, [])

    allow(Pugin::Feature::Bandiera).to receive(:show_committees?).and_return(true)

    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Test Name - Current and former Committees/)
    end
  end

  context 'partials' do
    it 'will render pugin/elements/_list' do
      expect(response).to render_template('pugin/elements/_list')
    end
  end

end
