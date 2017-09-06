require 'rails_helper'

RSpec.describe 'parties/members/a_to_z', vcr: true do
  before do
    assign(:letters, 'A')
    assign(:party_id, 'jF43Jxoc')
    @party = Class.new
    allow(@party).to receive(:name).and_return('Labour')
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Labour - Current and former MPs/)
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
