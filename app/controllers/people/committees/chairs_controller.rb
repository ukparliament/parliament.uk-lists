module People
  module Committees
    class ChairsController < ApplicationController
      before_action :data_check, :build_request

      # Data not yet available so commented out

      #ROUTE_MAP = {
      #  index: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_committees_chairs.set_url_params({ person_id: params[:person_id] }) }
      #}.freeze

      #def index
      #  @person, @committee_memberships, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      #    @request,
      #    'http://id.ukpds.org/schema/Person',
      #    'http://id.ukpds.org/schema/FormalBodyMembership',
      #    ::Grom::Node::BLANK
      #  )

      #  @person                = @person.first
      #  @committee_memberships = @committee_memberships.reverse_sort_by(:start_date)
      #  @letters               = @letters.map(&:value)
      #end
    end
  end
end
