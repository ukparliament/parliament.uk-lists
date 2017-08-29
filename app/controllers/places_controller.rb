class PlacesController < ApplicationController
  before_action :data_check, :build_request

  ROUTE_MAP = {
    index:  proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.region_index },
  }.freeze

  # Renders a list of regions
  # @return [Array] Grom::Nodes of type 'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion'.
  def index
    @places = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://data.ordnancesurvey.co.uk/ontology/admingeo/EuropeanRegion'
    )

    @places = @places.sort_by(:gss_code)

  end
end
