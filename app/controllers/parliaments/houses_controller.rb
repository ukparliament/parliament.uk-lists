module Parliaments
  class HousesController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliament_houses.set_url_params({ parliament_id: params[:parliament_id] }) },
    }.freeze

    def index
      @parliament, @houses = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
        @request,
        Parliament::Utils::Helpers::RequestHelper.namespace_uri_schema_path('ParliamentPeriod'),
        Parliament::Utils::Helpers::RequestHelper.namespace_uri_schema_path('House')
      )

      @parliament = @parliament.first
      @houses     = @houses.sort_by(:name)
    end

  end
end
