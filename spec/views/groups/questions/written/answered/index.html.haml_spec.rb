require 'rails_helper'

RSpec.describe 'groups/questions/written/answered/index', vcr: true do

  context 'answering body' do

    describe 'with page title' do
      before do
        assign(:answering_body, double(:answering_body,
          name: 'Answering body name'
        ))

        render
      end

      it 'will render a <div class=\'section--primary\' />' do
        expect(rendered).to include("<div class='section--primary'>")
      end

      it 'will render an <h1 /> containing the title and context' do
        expect(rendered).to include("<h1>\n<span>Answering body name<\/span>\n<span class='context'>Answers to written questions<\/span>\n<\/h1>")
      end
    end

    describe 'without page title' do
      before do
        assign(:answering_body, double(:answering_body,
          name: nil
        ))

        render
      end

      it 'will not render a <div class=\'section--primary\' />' do
        expect(rendered).not_to include("<div class='section--primary'>")
      end

      it 'will not render an <h1 /> containing a title and context' do
        expect(rendered).not_to include("<h1>\n<span>Answering body name<\/span>\n<span class='context'>Answers to written questions<\/span>\n<\/h1>")
      end
    end

    describe 'without @answering_body' do
      it 'will not render a <div class=\'section--primary\' />' do
        expect(rendered).not_to include("<div class='section--primary'>")
      end
    end

  end

  context 'answers grouped by date' do

    describe 'with date, with questions' do
      before do
        assign(:answers_grouped_by_date, {
          Time.parse('Fri, 06 Jul 2018 00:00:00 +0000') => [double(:answer,
            question: double(:question,
              heading: 'Question heading 1',
              graph_id: '11111111'
            )
          )]
        })

        render
      end

      it 'will render the main <section />' do
        expect(rendered).to include("<section id='content' tabindex='0'>")
      end

      it 'will render an <h2 /> containing <time />' do
        expect(rendered).to include("<h2>\n<time datetime='2018-07-06'>6 July 2018<\/time>\n<\/h2>")
      end

      it 'will render a link to a question' do
        expect(rendered).to have_link("Question heading 1", href: question_path("11111111"))
      end
    end

    describe 'without date, with questions' do
      before do
        assign(:answers_grouped_by_date, {
          nil => [double(:answer,
            question: double(:question,
              heading: 'Question heading 1',
              graph_id: '11111111'
            )
          )]
        })

        render
      end

      it 'will render the main <section />' do
        expect(rendered).to include("<section id='content' tabindex='0'>")
      end

      it 'will not render an <h2 /> containing <time />' do
        expect(rendered).not_to include("<h2>\n<time datetime='2018-07-06'>6 July 2018<\/time>\n<\/h2>")
      end

      it 'will render a link to a question' do
        expect(rendered).to have_link("Question heading 1", href: question_path("11111111"))
      end
    end

    describe 'without questions' do
      before do
        assign(:answers_grouped_by_date, {
          Time.parse('Fri, 06 Jul 2018 00:00:00 +0000') => []
        })

        render
      end

      it 'will render the main <section />' do
        expect(rendered).to include("<section id='content' tabindex='0'>")
      end

      it 'will not render an <h2 /> containing <time />' do
        expect(rendered).not_to include("<h2>\n<time datetime='2018-07-06'>6 July 2018<\/time>\n<\/h2>")
      end

      it 'will not render a link to a question' do
        expect(rendered).not_to have_link("Question heading 1", href: question_path("11111111"))
      end
    end

    describe 'without @answers_grouped_by_date' do
      it 'will not render the main <section />' do
        expect(rendered).not_to include("<section id='content' tabindex='0'>")
      end
    end

  end

end
