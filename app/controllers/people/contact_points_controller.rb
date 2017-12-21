module People
  class ContactPointsController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_contact_points.set_url_params({ person_id: params[:person_id] }) }
    }.freeze

    def index
      @person, @contact_points = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Person', 'ContactPoint')
      @person = @person.first
    end
  end
end
