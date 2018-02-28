module Groups
  class GovernmentOrganisationsController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index:             proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_government_organisation_index },
      current:           proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_government_organisation_current },
      letters:           proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_government_organisation_by_initial.set_url_params({ initial: params[:letter] }) },
      current_letters:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_government_organisation_current_by_initial.set_url_params({ initial: params[:letter] }) },
      a_to_z:            proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_government_organisation_a_to_z },
      a_to_z_current:    proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_government_organisation_current_a_to_z }
    }.freeze

    def index
      @government_organisations, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'GovRegisterGovernmentOrganisation', ::Grom::Node::BLANK)
      @all_path = :groups_government_organisations_path
    end

    def current
      @government_organisations, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'GovRegisterGovernmentOrganisation', ::Grom::Node::BLANK)
      @all_path = :groups_government_organisations_current_path
    end

    def letters
      @government_organisations, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'GovRegisterGovernmentOrganisation', ::Grom::Node::BLANK)
      @all_path = :groups_government_organisations_path
    end

    def current_letters
      @government_organisations, @letters = Parliament::Utils::Helpers::FilterHelper.filter_sort(@request, :name, 'GovRegisterGovernmentOrganisation', ::Grom::Node::BLANK)
      @all_path = :groups_government_organisations_current_path
    end

    def a_to_z
      @letters = Parliament::Utils::Helpers::RequestHelper.process_available_letters(@request)
      @all_path = :groups_government_organisations_path
    end

    def a_to_z_current
      @letters = Parliament::Utils::Helpers::RequestHelper.process_available_letters(@request)
      @all_path = :groups_government_organisations_current_path
    end
  end
end
