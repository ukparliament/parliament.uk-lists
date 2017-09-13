require 'rails_helper'

RSpec.describe 'houses', type: :routing do
  describe 'HousesController' do
    include_examples 'index route', 'houses'

    context 'house' do
      context 'members' do
        it 'GET houses/members#index' do
          expect(get: '/houses/KL2k1BGP/members').to route_to(
            controller: 'houses/members',
            action:     'index',
            house_id:   'KL2k1BGP',
          )
        end

        it 'GET houses/members#a_to_z' do
          expect(get: '/houses/KL2k1BGP/members/a-z').to route_to(
            controller: 'houses/members',
            action:     'a_to_z',
            house_id:   'KL2k1BGP',
          )
        end

        it 'GET houses/members#current' do
          expect(get: '/houses/KL2k1BGP/members/current').to route_to(
            controller: 'houses/members',
            action:     'current',
            house_id:   'KL2k1BGP',
          )
        end

        it 'GET houses/members#a_to_z_current' do
          expect(get: '/houses/KL2k1BGP/members/current/a-z').to route_to(
            controller: 'houses/members',
            action:     'a_to_z_current',
            house_id:   'KL2k1BGP',
          )
        end

        it 'GET houses/members#letters' do
          expect(get: '/houses/KL2k1BGP/members/a-z/a').to route_to(
            controller: 'houses/members',
            action:     'letters',
            house_id:   'KL2k1BGP',
            letter:     'a'
          )
        end

        it 'GET houses/members#current_letters' do
          expect(get: '/houses/KL2k1BGP/members/current/a-z/a').to route_to(
            controller: 'houses/members',
            action:     'current_letters',
            house_id:   'KL2k1BGP',
            letter:     'a'
          )
        end
      end

      context 'parties' do
        it 'GET houses/parties#index' do
          expect(get: '/houses/KL2k1BGP/parties').to route_to(
            controller: 'houses/parties',
            action:     'index',
            house_id:   'KL2k1BGP',
          )
        end

        it 'GET houses/parties#current' do
          expect(get: '/houses/KL2k1BGP/parties/current').to route_to(
            controller: 'houses/parties',
            action:     'current',
            house_id:   'KL2k1BGP',
          )
        end
      end

      context 'parties members' do
        it 'GET houses/parties/members#index' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members').to route_to(
            controller: 'houses/parties/members',
            action:     'index',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses/parties/members#a_to_z' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/a-z').to route_to(
            controller: 'houses/parties/members',
            action:     'a_to_z',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses/parties/members#letters' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/a-z/a').to route_to(
            controller: 'houses/parties/members',
            action:     'letters',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc',
            letter:     'a'
          )
        end

        it 'GET houses/parties/members#current' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/current').to route_to(
            controller: 'houses/parties/members',
            action:     'current',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses/parties/members#a_to_z_current' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/current/a-z').to route_to(
            controller: 'houses/parties/members',
            action:     'a_to_z_current',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc'
          )
        end

        it 'GET houses/parties/members#current_letters' do
          expect(get: '/houses/KL2k1BGP/parties/jF43Jxoc/members/current/a-z/a').to route_to(
            controller: 'houses/parties/members',
            action:     'current_letters',
            house_id:   'KL2k1BGP',
            party_id:   'jF43Jxoc',
            letter:     'a'
          )
        end
      end

      context 'committees' do
        it 'GET houses/:house_id/committees#index' do
          expect(get: '/houses/KL2k1BGP/committees').to route_to(
            controller: 'houses/committees',
            action:     'index',
            house_id:   'KL2k1BGP'
          )
        end

        it 'GET houses/:house_id/committees#a_to_z' do
          expect(get: '/houses/KL2k1BGP/committees/a-z').to route_to(
            controller: 'houses/committees',
            action:     'a_to_z',
            house_id:   'KL2k1BGP'
          )
        end

        it 'GET houses/:house_id/committees#letters' do
          expect(get: '/houses/KL2k1BGP/committees/a-z/a').to route_to(
            controller: 'houses/committees',
            action:     'letters',
            house_id:   'KL2k1BGP',
            letter:     'a'
          )
        end

        it 'GET houses/:house_id/committees#current' do
          expect(get: '/houses/KL2k1BGP/committees/current').to route_to(
            controller: 'houses/committees',
            action:     'current',
            house_id:   'KL2k1BGP'
          )
        end

        it 'GET houses/:house_id/committees#a_to_z_current' do
          expect(get: '/houses/KL2k1BGP/committees/current/a-z').to route_to(
            controller: 'houses/committees',
            action:     'a_to_z_current',
            house_id:   'KL2k1BGP'
          )
        end

        it 'GET houses/:house_id/committees#current_letters' do
          expect(get: '/houses/KL2k1BGP/committees/current/a-z/a').to route_to(
            controller: 'houses/committees',
            action:     'current_letters',
            house_id:   'KL2k1BGP',
            letter:     'a'
          )
        end
      end

      it 'GET houses#lookup_by_letters' do
        expect(get: '/houses/a').to route_to(
        controller: 'houses',
        action:     'lookup_by_letters',
        letters:    'a'
        )
      end
    end
  end
end
