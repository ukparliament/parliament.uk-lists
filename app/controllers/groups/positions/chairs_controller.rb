module Groups
  module Positions
    class ChairsController < ApplicationController
      before_action :data_check, :build_request

      ROUTE_MAP = {
        index:    proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_positions_chairs_index.set_url_params({ group_id: params[:group_id]}) },
        current:  proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_positions_chairs_current.set_url_params({ group_id: params[:group_id]}) }
      }.freeze

      def index
        @group, @chairs = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'FormalBodyChair')
        @group = @group.first
      end

      def current
        @group, @chairs = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'FormalBodyChair')
        @group = @group.first
      end
    end
  end
end
