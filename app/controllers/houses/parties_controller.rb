module Houses
  class PartiesController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index:   proc { |params| ParliamentHelper.parliament_request.houses(params[:house_id]).parties },
      current: proc { |params| ParliamentHelper.parliament_request.houses(params[:house_id]).parties.current }
      }.freeze

    def index
      @house, @parties = RequestHelper.filter_response_data(
        @request,
        'http://id.ukpds.org/schema/House',
        'http://id.ukpds.org/schema/Party'
      )

      @house = @house.first
      @parties = @parties.sort_by(:name)
    end

    def current
      @house, @parties = RequestHelper.filter_response_data(
        @request,
        'http://id.ukpds.org/schema/House',
        'http://id.ukpds.org/schema/Party'
      )

      @house = @house.first
      @parties = @parties.multi_direction_sort({ member_count: :desc, name: :asc })
    end
  end
end
