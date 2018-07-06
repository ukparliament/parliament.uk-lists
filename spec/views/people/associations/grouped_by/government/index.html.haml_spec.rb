require 'rails_helper'

RSpec.describe 'people/associations/grouped_by/government/index', vcr: true do
  constituency_graph_id     = 'MtbjxRrE'
  government_graph_id       = ''

    before do
      assign(:person,
        double(:person,
          display_name:   'Test Display Name',
          full_name:      'Test Full Name',
          statuses:       { house_membership_status: ['Current MP'] },
          graph_id:       '7TX8ySd4',
          image_id:       'CCCCCCCC',
          current_mp?:    true,
          current_lord?:  false))

      assign(:image,
          double(:image,
            graph_id:     'XXXXXXXX'))

      assign(:current_incumbency,
        double(:current_incumbency,
          constituency: double(:constituency, name: 'Aberavon', graph_id: constituency_graph_id, date_range: 'from 2010')))
      assign(:most_recent_incumbency, nil)
      assign(:history, {
      start: double(:start, year: Time.zone.now - 5.years),
      current: [],
      years: {} })
      assign(:seat_incumbencies, count: 2)
      assign(:government_incumbencies, [
        double(:government_incumbency,
               type: '/GovernmentIncumbency',
               date_range: "from #{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present",
               government_position: double(:government_position,
                                   name: 'Test Government Position Name',
                                   graph_id:   government_graph_id,
          )
        )
      ])
      assign(:current_party_membership,
        double(:current_party_membership,
          party: double(:party,
            name: 'Conservative',
            graph_id: 'jF43Jxoc')
        )
      )

      assign(:sorted_incumbencies, [
        double(:first_incumbency,
          start_date: Time.zone.now - 5.years
        )
      ])

      render
    end

  context 'header' do
    it 'will render the display name' do
      expect(rendered).to match(/Test Display Name/)
    end
  end

  context '@government_incumbencies are present' do
    before :each do
      assign(:history, {
        start: Time.zone.now - 25.years,
        current: [
          double(:government_incumbency,
            type: '/GovernmentIncumbency',
            date_range: "from #{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present",
            government_position:
              double(:government_position,
                name: 'Test Government Position Name',
                graph_id:   government_graph_id
              )
          )
        ],
        years: {
          '10': [
            double(:government_incumbency,
              type: '/GovernmentIncumbency',
              date_range: "from #{(Time.zone.now - 5.years).strftime('%-e %b %Y')} to #{(Time.zone.now - 3.years).strftime('%-e %b %Y')}",
              government_position:
                double(:government_position,
                  name: 'Second Government Positon Name',
                  graph_id:   government_graph_id,
                )
            )
          ]
        }
      })

      assign(:current_roles, {
        "GovernmentIncumbency" => [
          double(:government_incumbency,
            type: '/GovernmentIncumbency',
            date_range: "from #{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present",
            government_position:
              double(:government_position,
                name: 'Test Government Position Name',
                graph_id:   government_graph_id,
            )
          )
        ]
      })

      render
    end

    context 'showing current' do
      context 'Government roles' do
        it 'will render the correct sub-header' do
          expect(rendered).to match(/Government role/)
        end

        it 'will render the correct title' do
          expect(rendered).to match(/Test Government Position Name/)
        end

        it 'will render start date to present' do
          expect(rendered).to match("#{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present")
        end
      end
    end

    context 'showing historic' do
      it 'shows header' do
        expect(rendered).to match(/Held in the last 10 years/)
      end

      it 'will render the correct sub-header' do
        expect(rendered).to match(/Test Government Position Name/)
      end

      it 'will render the correct title' do
        expect(rendered).to match(/Second Government Positon Name/)
      end

      it 'will render start date to present' do
        expect(rendered).to match((Time.zone.now - 5.years).strftime('%-e %b %Y'))
      end

      it 'will render present status' do
        expect(rendered).to match((Time.zone.now - 3.years).strftime('%-e %b %Y'))
      end
    end

    context 'showing start date' do
      it 'shows start date' do
        expect(rendered).to match((Time.zone.now - 5.years).strftime('%Y'))
      end
    end
  end

  context '@government_incumbencies are not present' do
    context 'with roles' do
      let(:history) {}

      before :each do
        assign(:history, history)
        assign(:government_incumbencies, [])
        render
      end

      it 'shows no government roles message' do
        expect(rendered).to match(/No Government Roles/)
      end
    end
  end
end
