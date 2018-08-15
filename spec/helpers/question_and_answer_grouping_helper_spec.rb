require_relative '../rails_helper'

RSpec.describe QuestionAndAnswerGroupingHelper do
  let(:question1) { double('question1', date: DateTime.parse('Wed, 18 Oct 2017 00:00:00 +0000')) }
  let(:question2) { double('question2', date: DateTime.parse('Wed, 18 Oct 2017 00:00:00 +0000')) }
  let(:question3) { double('question3', date: DateTime.parse('Thu, 19 Oct 2017 00:00:00 +0000')) }
  let(:question4) { double('question4', date: DateTime.parse('Fri, 20 Oct 2017 00:00:00 +0000')) }
  let(:question5) { double('question5', date: DateTime.parse('Fri, 20 Oct 2017 00:00:00 +0000')) }
  let(:question6) { double('question6', date: DateTime.parse('Fri, 20 Oct 2017 00:00:00 +0000')) }
  let(:question7) { double('question7') }
  let(:question8) { double('question8') }

  let(:questions) { [question1, question2, question3, question4, question5, question6, question7, question8] }

  it 'is a module' do
    expect(subject).to be_a(Module)
  end

  context '#group' do
    it 'groups the object in a descending order' do
      hash = {
        DateTime.parse('Fri, 20 Oct 2017 00:00:00 +0000') => [question6, question5, question4],
        DateTime.parse('Thu, 19 Oct 2017 00:00:00 +0000') => [question3],
        DateTime.parse('Wed, 18 Oct 2017 00:00:00 +0000') => [question2, question1],
        nil => [question7, question8]
      }

      expect(subject.group(questions, :date)).to eq hash
    end
  end
end
