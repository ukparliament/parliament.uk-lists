module Groups
  class HousesController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_houses_index.set_url_params({ group_id: params[:group_id]}) }
    }.freeze

    def index
      @group, @houses, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Group', 'House', ::Grom::Node::BLANK)
      @group = @group.first
      @houses = @houses.sort_by(:name)
      @letters    = @letters.map(&:value)
    end
  end
end
