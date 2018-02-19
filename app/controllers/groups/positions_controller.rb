module Groups
  class PositionsController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index:    proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_positions_index.set_url_params({ group_id: params[:group_id]}) },
      current:  proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_positions_current.set_url_params({ group_id: params[:group_id]}) }
    }.freeze

    def index
      @group, @positions = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'Position')
      @group = @group.first
      @positions = @positions.sort_by(:name)
    end

    def current
      @group, @positions = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'Position')
      @group = @group.first
      @positions = @positions.sort_by(:name)
    end
  end
end
