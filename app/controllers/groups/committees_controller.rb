module Groups
  class CommitteesController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index:           proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_committees_index },
      current:         proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_committees_current },
      letters:         proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_committees_by_initial.set_url_params({ initial: params[:letter]}) },
      current_letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_committees_current_by_initial.set_url_params({ initial: params[:letter]}) },
      a_to_z:          proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_committees_a_to_z },
      a_to_z_current:  proc { Parliament::Utils::Helpers::ParliamentHelper.parliament_request.group_committees_a_to_z_current }
    }.freeze

    def index
      @parliamentary_committees, @statutory_committees, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'ParliamentaryCommittee', 'StatutoryCommittee', ::Grom::Node::BLANK)

      @committees = Array(@parliamentary_committees) + Array(@statutory_committees)
      @committees = Parliament::NTriple::Utils.sort_by(
        {
          list:       @committees,
          parameters: [ :name ]
        }
      )

      @letters = @letters.map(&:value)
    end

    def current
      @parliamentary_committees, @statutory_committees, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'ParliamentaryCommittee', 'StatutoryCommittee', ::Grom::Node::BLANK)

      @committees = Array(@parliamentary_committees) + Array(@statutory_committees)
      @committees = Parliament::NTriple::Utils.sort_by(
        {
          list:       @committees,
          parameters: [ :name ]
        }
      )

      @letters = @letters.map(&:value)

      @all_path = :groups_committees_current_path
    end

    def letters
      @parliamentary_committees, @statutory_committees, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'ParliamentaryCommittee', 'StatutoryCommittee', ::Grom::Node::BLANK)

      @committees = Array(@parliamentary_committees) + Array(@statutory_committees)
      @committees = Parliament::NTriple::Utils.sort_by(
        {
          list:       @committees,
          parameters: [ :name ]
        }
      )

      @letters = @letters.map(&:value)
      @all_path = :groups_committees_path
    end

    def current_letters
      @parliamentary_committees, @statutory_committees, @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, 'ParliamentaryCommittee', 'StatutoryCommittee', ::Grom::Node::BLANK)

      @committees = Array(@parliamentary_committees) + Array(@statutory_committees)
      @committees = Parliament::NTriple::Utils.sort_by(
        {
          list:       @committees,
          parameters: [ :name ]
        }
      )

      @letters = @letters.map(&:value)
      @all_path = :groups_committees_current_path
    end

    def a_to_z
      @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, ::Grom::Node::BLANK)
      @letters = @letters.map(&:value)
      @all_path = :groups_committees_path
    end

    def a_to_z_current
      @letters = Parliament::Utils::Helpers::FilterHelper.filter(@request, ::Grom::Node::BLANK)
      @letters = @letters.map(&:value)
      @all_path = :groups_committees_current_path
    end
  end
end
