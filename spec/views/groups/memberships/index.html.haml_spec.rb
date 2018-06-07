require 'rails_helper'

RSpec.describe 'groups/memberships/index', vcr: true do
  before do
    assign(:group,
      double(:group,
        graph_id: 'tWzrJATE',
        name:     'Test Group Name'))
    assign(:chair_people,
      [
        double(:chair_people,
          graph_id:                '12341234',
          display_name:            'Test Chair Person Name',
          image_id:                'placeholder',
          current_mp?:             true,
          current_party:           double(:current_party, name: 'Test Party'),
          current_seat_incumbency: double(:current_seat_incumbency,
            constituency: double(:constituency, name: 'Test Chair Member Constituency')))
      ])
    assign(:non_chair_members,
      [
        double(:non_chair_members,
          graph_id:                  '1234abcd',
          display_name:              'Test Person Name',
          image_id:                  'placeholder',
          current_mp?:               true,
          current_party:             double(:current_party, name: 'Test Party'),
          committee_membership_type: ['Lay', 'committee member'],
          current_seat_incumbency:   double(:current_seat_incumbency,
            constituency: double(:constituency, name: 'Test Person Constituency')))
      ])
    assign(:letters, %w[a b c])
    assign(:all_path, :group_memberships_path)
    allow(Pugin::Feature::Bandiera).to receive(:show_list_images?).and_return(true)
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Current and former members - Test Group Name/)
    end
  end

  context 'letters' do
    it 'will render the all path' do
      expect(rendered).to match(/href="\/groups\/tWzrJATE\/memberships">/)
    end

    it 'will render the correct letters' do
      expect(rendered).to match(/data-letter='a'/)
      expect(rendered).to match(/data-letter='b'/)
      expect(rendered).to match(/data-letter='c'/)
    end
  end

  it 'will render the person image' do
    expect(rendered).to match(/placeholder/)
  end

  context 'chair person' do
    it 'will render member name' do
      expect(rendered).to match(/Test Chair Person Name/)
    end

    it 'will render membership type' do
      expect(rendered).to match(/Committee chair/)
    end

    it 'will render party and constituency' do
      expect(rendered).to match(/MP for Test Chair Member Constituency/)
    end
  end

  context 'non chair member' do
    it 'will render member name' do
      expect(rendered).to match(/Test Person Name/)
    end

    it 'will render membership type' do
      expect(rendered).to match(/Lay committee member/)
    end

    it 'will render party and constituency' do
      expect(rendered).to match(/MP for Test Person Constituency/)
    end
  end
end
