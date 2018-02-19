class GroupsController < ApplicationController
  before_action :data_check, :build_request

  ROUTE_MAP = {
    index:             proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_index },
    current:           proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_current },
    letters:           proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_by_initial.set_url_params({ initial: params[:letter] }) },
    current_letters:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_current_by_initial.set_url_params({ initial: params[:letter] }) },
    a_to_z:            proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_a_to_z },
    a_to_z_current:    proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_current_a_to_z },
    lookup_by_letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_by_substring.set_url_params({ substring: params[:letters] }) }
  }.freeze

  def index
    @groups, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'Group', ::Grom::Node::BLANK)
    @all_path = :groups_path
  end

  def current
    @groups, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'Group', ::Grom::Node::BLANK)
    @all_path = :groups_current_path
  end

  def letters
    @groups, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'Group', ::Grom::Node::BLANK)
    @all_path = :groups_path
  end

  def current_letters
    @groups, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'Group', ::Grom::Node::BLANK)
    @all_path = :groups_current_path
  end

  def a_to_z
    @letters = Parliament::Utils::Helpers::RequestHelper.process_available_letters(@request)
    @all_path = :groups_path
  end

  def a_to_z_current
    @letters = Parliament::Utils::Helpers::RequestHelper.process_available_letters(@request)
    @all_path = :groups_current_path
  end

  def lookup_by_letters
    @groups, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', ::Grom::Node::BLANK)
    return redirect_to group_path(@groups.first.graph_id) if @groups.size == 1
    @groups = @groups.sort_by(:name)
    @letters = @letters.map(&:value)
  end
end
