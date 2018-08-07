module Groups
  module Questions
    module Written
      class AnsweredController < ApplicationController
        before_action :data_check, :build_request

        ROUTE_MAP = {
          index:    proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_questions_written_answered.set_url_params({ group_id: params[:group_id]}) }
        }.freeze

        def index
          @answering_body, @answers = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'AnsweringBody', 'Answer')

          @answering_body = @answering_body.first

          @answers_grouped_by_date = QuestionAndAnswerGroupingHelper.group(@answers, :answer_given_date)
        end
      end
    end
  end
end
