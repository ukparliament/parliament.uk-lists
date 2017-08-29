require 'rails_helper'

RSpec.describe 'parties/members/current_letters', vcr: true do
  before do
    allow(Parliament::Utils::Helpers::FlagHelper).to receive(:dissolution?).and_return(true)
    assign(:people, [])
    assign(:party, double(:party, name: 'Conservative', graph_id: 'jF43Jxoc'))
    assign(:letters, 'A')
    allow(view).to receive(:house_parties_party_members_path).and_return('/houses/Kz7ncmrt/parties/AJgeHzL2/members')
    controller.params = { letter: 'a' }
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Conservative - Current members/)
    end
  end

  context 'partials' do
    it 'will render pugin/components/_navigation-letter' do
      expect(response).to render_template(partial: 'pugin/components/_navigation-letter')
    end

    it 'will render pugin/elements/_list' do
      expect(response).to render_template('pugin/elements/_list')
    end

    it 'will render dissolution message' do
      expect(response).to render_template(partial: 'shared/_dissolution_message')
    end
  end
end
