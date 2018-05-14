require 'rails_helper'

RSpec.describe Groups::MembershipsController, vcr: true do
  describe 'GET index' do
    before(:each) do
      get :index, params: { group_id: 'tWzrJATE' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context 'instance variable assignment' do
      it 'assigns @group' do
        expect(assigns(:group)).to be_a(Grom::Node)
        expect(assigns(:group).type.first).to eq('https://id.parliament.uk/schema/Group')
      end

      it 'assigns @people' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      it 'assigns @chair_people' do
        assigns(:chair_people).each do |chair_person|
          expect(chair_person).to be_a(Grom::Node)
          expect(chair_person.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
        expect(assigns(:letters).first).to eq('B')
      end

      it 'assigns @non_chair_members' do
        assigns(:non_chair_members).each do |non_chair_members|
          expect(non_chair_members).to be_a(Grom::Node)
          expect(non_chair_members.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      context 'non-chair members' do
        it 'will not include chair people' do
          expect(assigns(:non_chair_members)).to_not include(assigns(:chair_people))
        end
      end
    end
  end

  describe 'GET current' do
    before(:each) do
      get :current, params: { group_id: 'tWzrJATE' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context 'instance variable assignment' do
      it 'assigns @group' do
        expect(assigns(:group)).to be_a(Grom::Node)
        expect(assigns(:group).type.first).to eq('https://id.parliament.uk/schema/Group')
      end

      it 'assigns @people' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      it 'assigns @chair_people' do
        assigns(:chair_people).each do |chair_person|
          expect(chair_person).to be_a(Grom::Node)
          expect(chair_person.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      it 'assigns @non_chair_members' do
        assigns(:non_chair_members).each do |non_chair_members|
          expect(non_chair_members).to be_a(Grom::Node)
          expect(non_chair_members.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      context 'non-chair members' do
        it 'will not include chair people' do
          expect(assigns(:non_chair_members)).to_not include(assigns(:chair_people))
        end
      end
    end
  end

  describe 'GET a_to_z' do
    before(:each) do
      get :a_to_z, params: { group_id: 'tWzrJATE' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context 'instance variable assignment' do
      it 'assigns @group' do
        expect(assigns(:group)).to be_a(Grom::Node)
        expect(assigns(:group).type).to eq('https://id.parliament.uk/schema/Group')
      end

      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
        expect(assigns(:letters).first).to eq('B')
      end

      it 'assigns @all_path' do
        expect(assigns(:all_path)).to eq(:group_memberships_path)
      end
    end
  end

  describe 'GET letters' do
    before(:each) do
      get :letters, params: { group_id: 'tWzrJATE', letter: 'a' }
    end

    it 'should have a response with http status ok (200)' do
      expect(response).to have_http_status(:ok)
    end

    context 'instance variable assignment' do
      it 'assigns @group' do
        expect(assigns(:group)).to be_a(Grom::Node)
        expect(assigns(:group).type.first).to eq('https://id.parliament.uk/schema/Group')
      end

      it 'assigns @people' do
        assigns(:people).each do |person|
          expect(person).to be_a(Grom::Node)
          expect(person.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      it 'assigns @chair_people' do
        assigns(:chair_people).each do |chair_person|
          expect(chair_person).to be_a(Grom::Node)
          expect(chair_person.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      it 'assigns @letters' do
        expect(assigns(:letters)).to be_a(Array)
        expect(assigns(:letters).first).to eq('B')
      end

      it 'assigns @non_chair_members' do
        assigns(:non_chair_members).each do |non_chair_members|
          expect(non_chair_members).to be_a(Grom::Node)
          expect(non_chair_members.type).to eq('https://id.parliament.uk/schema/Person')
        end
      end

      it 'assigns @all_path' do
        expect(assigns(:all_path)).to eq(:group_memberships_path)
      end

      context 'non-chair members' do
        it 'will not include chair people' do
          expect(assigns(:non_chair_members)).to_not include(assigns(:chair_people))
        end
      end
    end
  end

  describe '#data_check' do
    context 'an available data format is requested' do
      methods = [
        {
          route:      'index',
          parameters: { group_id: 'tWzrJATE' },
          data_url:   "#{ENV['PARLIAMENT_BASE_URL']}/group_memberships_index?group_id=tWzrJATE"
        },
        {
          route:      'current',
          parameters: { group_id: 'tWzrJATE' },
          data_url:   "#{ENV['PARLIAMENT_BASE_URL']}/group_current_memberships?group_id=tWzrJATE"
        },
        {
          route:      'letters',
          parameters: { letter: 'l', group_id: 'tWzrJATE' },
          data_url:   "#{ENV['PARLIAMENT_BASE_URL']}/group_memberships_by_initial?group_id=tWzrJATE&initial=l"
        },
        {
          route:      'a_to_z',
          parameters: { group_id: 'tWzrJATE' },
          data_url:   "#{ENV['PARLIAMENT_BASE_URL']}/group_memberships_a_to_z?group_id=tWzrJATE"
        }
      ]

      before(:each) do
        headers = { 'Accept' => 'application/rdf+xml' }
        request.headers.merge(headers)
      end

      it 'should have a response with http status redirect (302)' do
        methods.each do |method|
          if method.include?(:parameters)
            get method[:route].to_sym, params: method[:parameters]
          else
            get method[:route].to_sym
          end
          expect(response).to have_http_status(302)
        end
      end

      it 'redirects to the data service' do
        methods.each do |method|
          if method.include?(:parameters)
            get method[:route].to_sym, params: method[:parameters]
          else
            get method[:route].to_sym
          end
          expect(response).to redirect_to(method[:data_url])
        end
      end
    end
  end
end
