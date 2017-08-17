require 'rails_helper'

RSpec.describe 'places', type: :routing do
  context 'places' do
    it 'GET places#index' do
      expect(get: '/places').to route_to(
      controller: 'places',
      action:     'index',
      )
    end
  end

  context 'regions' do
    it 'GET places/regions#index' do
      expect(get: '/places/regions').to route_to(
      controller: 'places/regions',
      action:     'index',
      )
    end
  end

  context 'constituencies' do
    it 'GET places/constituencies#index' do
      expect(get: '/places/E15000001/constituencies').to route_to(
      controller: 'places/constituencies',
      action:     'index',
      place_id:   'E15000001'
      )
    end

    it 'GET places/constituencies#a_to_z' do
      expect(get: '/places/E15000001/constituencies/a-z').to route_to(
      controller: 'places/constituencies',
      action:     'a_to_z',
      place_id:   'E15000001'
      )
    end

    it 'GET places/constituencies#letters' do
      expect(get: '/places/E15000001/constituencies/a-z/d').to route_to(
      controller: 'places/constituencies',
      action:     'letters',
      place_id:   'E15000001',
      letter:     'd'
      )
    end
  end
end
