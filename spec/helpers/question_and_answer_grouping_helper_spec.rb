require_relative '../rails_helper'

RSpec.describe QuestionAndAnswerGroupingHelper do
  let(:question1) { double('question1', date: 1) }
  let(:question2) { double('question2', date: 1) }
  let(:question3) { double('question3', date: 2) }
  let(:question4) { double('question4', date: 3) }
  let(:question5) { double('question5', date: 3) }
  let(:question6) { double('question6', date: 3) }
  let(:question7) { double('question7') }
  let(:question8) { double('question8') }

  let(:questions) { [question1, question2, question3, question4, question5, question6, question7, question8] }

  it 'is a module' do
    expect(subject).to be_a(Module)
  end

  context '#group' do
    it 'groups the object in a descending order' do
      hash = {
        3 => [question6, question5, question4],
        2 => [question3],
        1 => [question2, question1],
        nil => [question7, question8]
      }

      expect(subject.group(questions, :date)).to eq hash
    end
  end
end
