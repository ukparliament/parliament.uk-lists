require 'rails_helper'

RSpec.describe 'groups/questions/written/answered/index', vcr: true do

  before do

    assign(:answering_body, double(:answering_body,
      name: 'Answering body name'
    ))

    assign(:answers_grouped_by_date, {
      Date.parse('Fri, 06 Jul 2018 00:00:00 +0000') => [double(:answer,
        question: double(:question,
          heading: 'Question heading 1',
          graph_id: '11111111'
        )
      )]
    })

    render

  end

  it 'will render a page heading' do
    expect(rendered).to include("<h1>\n<span>Answering body name<\/span>\n<\/h1>")
  end

  it 'will render a date inside the time tag with the datetime attribute' do
    expect(rendered).to include("<time datetime='2018-07-06'>06 July 2018<\/time>")
  end

  it 'will render a link to a question' do
    expect(rendered).to have_link('Question heading 1', href: question_path('11111111'))
  end

end
