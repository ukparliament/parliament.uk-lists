require 'rails_helper'

RSpec.describe 'contact points', type: :routing do
  describe 'ContactPointsController' do
    context 'index' do
      it 'GET contact_points#index' do
        expect(get: '/contact-points').to route_to(
          controller: 'contact_points',
          action:     'index'
        )
      end
    end
  end
end
