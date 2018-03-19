require 'rails_helper'

RSpec.describe 'houses/parties/current', vcr: true do
  before do
    allow(Parliament::Utils::Helpers::FlagHelper).to receive(:dissolution?).and_return(true)
    assign(:house, double(:house, name: 'House of Commons', graph_id: 'Kz7ncmrt'))
    @parties = [double(:party, name: 'Conservative', graph_id: '891w1b1k', member_count: 10)]
    allow(Pugin::Feature::Bandiera).to receive(:show_lords_ineligibility_banner?).and_return(true)
    render
  end

  context 'header' do
    it 'will render the current person type' do
      expect(rendered).to match(/Current parties/)
    end
  end

  context 'partials' do
    it 'will render party' do
      expect(response).to render_template(partial: 'houses/parties/_party')
    end

    it 'will render dissolution message' do
      expect(response).to render_template(partial: 'shared/_dissolution_message')
    end

    it 'will render a banner about lords ineligibility' do
      expect(rendered).to match('Lords who are not eligible to take part in the work of Parliament are excluded from the numbers shown below. Their names and reasons for ineligibility are <a href="http://www.parliament.uk/mps-lords-and-offices/lords/-ineligible-lords/">available here</a>.')
    end
  end

  context 'links' do
    it 'will render tab link to house_parties_current_path' do
      expect(rendered).to have_link('Lords', href: house_parties_current_path('MvLURLV5'))
    end
  end
end
