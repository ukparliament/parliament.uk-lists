module People
  module Associations
    module GroupedBy
      class GovernmentController < ApplicationController
        before_action :data_check, :build_request

        ROUTE_MAP = {
          index:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_associations_grouped_by_government.set_url_params({ person_id: params[:person_id] }) },
        }.freeze

        def index
          @person, @seat_incumbencies, @government_incumbencies = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Person', 'SeatIncumbency', 'GovernmentIncumbency')

          @person = @person.first

          # Only seat incumbencies, not committee roles are being grouped
          incumbencies = RoleGroupingHelper.group(@seat_incumbencies, :constituency, :graph_id)

          @sorted_incumbencies = Parliament::NTriple::Utils.sort_by({
            list:             @person.incumbencies,
            parameters:       [:start_date],
            prepend_rejected: false
          })

          HistoryHelper.reset
          HistoryHelper.add(@government_incumbencies.to_a)
          @history = HistoryHelper.history
        end
      end
    end
  end
end
