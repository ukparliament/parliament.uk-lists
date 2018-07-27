module People
  module Questions
    class WrittenController < ApplicationController
      before_action :data_check, :build_request

      ROUTE_MAP = {
        index:   proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_questions_written.set_url_params({ person_id: params[:person_id] }) },
      }.freeze

      def index
        @questions, @asking_person = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'Question', 'Person')

        @questions_grouped_by_date = QuestionAndAnswerGroupingHelper.group(@questions, :asked_at_date)

        @asking_person = @asking_person.first
      end
    end
  end
end
