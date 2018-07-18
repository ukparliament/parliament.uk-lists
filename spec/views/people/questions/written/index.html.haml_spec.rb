require 'rails_helper'

RSpec.describe 'people/questions/written/index' do
  before do
    assign(:asking_person,
      double(:asking_person,
        display_name:   'Test Display Name',
        image_id:       '12345678',
        graph_id:       'xcvbnmjk'))

    assign(:image,
      double(:image,
        graph_id:     'XXXXXXXX'))

    assign(:questions_grouped_by_date, {
      Time.zone.now - 12.days => [
        double(:question1,
          heading: "Question heading 1",
          graph_id: "1w23e4r5",
          answers: [double(:answer)],
          answering_body_allocation: double(:answering_body_allocation,
            answering_body: double(:answering_body, name: 'Example Answering Body Name')
          )
        )
      ]
    })

    render
  end

  it 'will have a link to the person' do
    expect(rendered).to have_link('Test Display Name', href: person_path('xcvbnmjk'))
  end

  context 'questions grouped by date' do
    it 'will render date' do
      expect(rendered).to match(/#{(Time.zone.now - 12.days).strftime('%-e %B %Y')}/)
    end

    it 'will have a link to the question' do
      expect(rendered).to have_link('Question heading 1', href: question_path('1w23e4r5'))
    end

    context 'question is not answered' do
      before do
        assign(:questions_grouped_by_date, {
          Timecop.freeze(Time.zone.now - 12.days) => [
            double(:question1,
              heading: "Question heading 1",
              graph_id: "1w23e4r5",
              answers: [],
              answering_body_allocation: double(:answering_body_allocation,
                answering_body: double(:answering_body, name: 'Example Answering Body Name')
              )
            )
          ]
        })

        render
      end

      it 'will render awaiting answer' do
        expect(rendered).to match(/Awaiting answer/)
      end
    end

    context 'question has been answered' do
      it 'will render Answered by the' do
        expect(rendered).to match(/Answered by the Example Answering Body Name/)
      end
    end
  end
end
