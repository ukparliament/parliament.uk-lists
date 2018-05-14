module Groups
  class MembershipsController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_memberships_index.set_url_params({ group_id: params[:group_id] }) },
      current: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_current_memberships.set_url_params({ group_id: params[:group_id] }) },
      letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_memberships_by_initial.set_url_params({ group_id: params[:group_id], initial: params[:letter]}) },
      a_to_z:  proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_memberships_a_to_z.set_url_params({ group_id: params[:group_id] }) },
    }.freeze

    def index
      @group, @people, @positions, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'Person', 'Position', ::Grom::Node::BLANK)
      @group = @group.first
      @people = @people.sort_by(:sort_name)
      @chair_people = @positions.map { |chair| chair.incumbencies.map(&:people) }.flatten.uniq
      @non_chair_members = Array(@people) - Array(@chair_people)
      @letters = @letters.map(&:value)
    end

    def current
      @group, @people, @positions = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'Person', 'Position')
      @group = @group.first
      @people = @people.sort_by(:sort_name)
      @chair_people = @positions.map { |chair| chair.incumbencies.map(&:people) }.flatten.uniq
      @non_chair_members = Array(@people) - Array(@chair_people)
    end

    def a_to_z
      @group, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', ::Grom::Node::BLANK)
      @group = @group.first
      @letters = @letters.map(&:value)
      @all_path = :group_memberships_path
    end

    def letters
      @group, @people, @positions, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'Person', 'Position', ::Grom::Node::BLANK)
      @group = @group.first
      @people = @people.sort_by(:sort_name)
      @chair_people = @positions.map { |chair| chair.incumbencies.map(&:people) }.flatten.uniq
      @chair_people = @chair_people.reject { |chair_person| chair_person.is_a?(String) }
      @non_chair_members = Array(@people) - Array(@chair_people)
      @letters = @letters.map(&:value)
      @all_path = :group_memberships_path
    end
  end
end
