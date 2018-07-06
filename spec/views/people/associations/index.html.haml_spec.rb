require 'rails_helper'

RSpec.describe 'people/associations/index', vcr: true do
  constituency_graph_id     = 'MtbjxRrE'
  government_graph_id       = 'NprsWxpz'
  opposition_graph_id       = ''
  context 'with roles' do
    before do
      assign(:person,
        double(:person,
          display_name:   'Test Display Name',
          full_title:     'Test Title',
          full_name:      'Test Full Name',
          gender_pronoun: 'She',
          image_id:       'CCCCCCCC',
          statuses:       { house_membership_status: ['Current MP'] },
          graph_id:       '7TX8ySd4',
          current_mp?:    true,
          current_lord?:  false,
          mnis_id:        '1357',
          weblinks?:      false))

      assign(:image,
        double(:image,
          graph_id:     'XXXXXXXX'))

      assign(:seat_incumbencies, count: 2)
      assign(:committee_memberships, count: 2)
      assign(:government_incumbencies, count: 2)


      assign(:history, {
        start: Time.zone.now - 25.years,
        current: [
          double(:seat_incumbency,
            house_of_commons?: true,
            house_of_lords?: false,
            type: '/SeatIncumbency',
            date_range: "from #{(Time.zone.now - 2.months).strftime('%-e %b %Y')} to present",
            constituency: double(:constituency,
              name:       'Aberconwy',
              graph_id:   constituency_graph_id,
            )
          ),
          double(:committee_membership,
            type: '/FormalBodyMembership',
            date_range: "from #{(Time.zone.now - 3.months).strftime('%-e %b %Y')} to present",
            formal_body: double(:formal_body,
              name: 'Test Committee Name',
              graph_id:   constituency_graph_id,
            )
          ),
          double(:government_incumbency,
                 type: '/GovernmentIncumbency',
                 date_range: "from #{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present",
                 government_position: double(:government_position,
                                     name: 'Test Government Position Name',
                                     graph_id:   government_graph_id,
            )
          ),
          double(:opposition_incumbency,
                 type: '/OppositionIncumbency',
                 date_range: "from #{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present",
                 opposition_position: double(:opposition_position,
                                     name: 'Opposition Role 1',
                                     graph_id:   opposition_graph_id,
            )
          ),
          double(:seat_incumbency,
            type: '/SeatIncumbency',
            house_of_commons?: true,
            house_of_lords?: false,
            start_date: Time.zone.now - 2.months,
            end_date:   nil,
            date_range: "from #{(Time.zone.now - 4.months).strftime('%-e %b %Y')} to present",
            constituency: double(:constituency,
              name:       'Fake Place 2',
              graph_id:   constituency_graph_id,
            )
          )
        ],
        years: {
          '10': [
            double(:committee_membership,
              type: '/FormalBodyMembership',
              date_range: "from #{(Time.zone.now - 8.years).strftime('%-e %b %Y')} to #{(Time.zone.now - 7.years).strftime('%-e %b %Y')}",
              formal_body: double(:formal_body,
                name: 'Second Committee Name',
                graph_id:   constituency_graph_id,
              )
            ),
            double(:government_incumbency,
               type: '/GovernmentIncumbency',
               date_range: "from #{(Time.zone.now - 5.years).strftime('%-e %b %Y')} to #{(Time.zone.now - 3.years).strftime('%-e %b %Y')}",
               government_position: double(:government_position,
                 name: 'Second Government Positon Name',
                 graph_id:   government_graph_id,
               )
            ),
            double(:opposition_incumbency,
               type: '/OppositionIncumbency',
               date_range: "from #{(Time.zone.now - 5.years).strftime('%-e %b %Y')} to #{(Time.zone.now - 3.years).strftime('%-e %b %Y')}",
               opposition_position: double(:opposition_position,
                 name: 'Opposition Role 2',
                 graph_id:   opposition_graph_id,
               )
            ),
            double(:seat_incumbency,
              type: '/SeatIncumbency',
              house_of_commons?: true,
              house_of_lords?: false,
              start_date: Time.zone.now - 6.months,
              date_range: "from #{(Time.zone.now - 6.months).strftime('%-e %b %Y')} to #{(Time.zone.now - 1.week).strftime('%-e %b %Y')}",
              constituency: double(:constituency,
                name:       'Fake Place 1',
                graph_id:   constituency_graph_id,
              )
            )
          ]
        }
      })

      assign(:current_roles, {
        'FormalBodyMembership'.to_s => [
          double(:committee_membership1,
            type: '/FormalBodyMembership',
            date_range: "from #{(Time.zone.now - 12.months).strftime('%-e %b %Y')} to present",
            formal_body: double(:formal_body,
              name: 'Test Committee Name 1',
              graph_id:   constituency_graph_id,
            )
          ),
          double(:committee_membership2,
            type: '/FormalBodyMembership',
            date_range: "from #{(Time.zone.now - 8.months).strftime('%-e %b %Y')} to present",
            formal_body: double(:formal_body,
              name: 'Test Committee Name 2',
              graph_id:   constituency_graph_id,
            )
          ),
          double(:committee_membership3,
            type: '/FormalBodyMembership',
            date_range: "from #{(Time.zone.now - 9.months).strftime('%-e %b %Y')} to present",
            formal_body: double(:formal_body,
              name: 'Test Committee Name 3',
              graph_id:   constituency_graph_id,
            )
          )
        ],
        'OppositionIncumbency'.to_s => [
          double(:opposition_incumbency,
            type: '/OppositionIncumbency',
            date_range: "from #{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present",
            opposition_position: double(:opposition_position,
              name: 'Opposition Role 1',
              graph_id:   opposition_graph_id,
            )
          )
        ],
        "GovernmentIncumbency" => [
          double(:government_incumbency,
            type: '/GovernmentIncumbency',
            date_range: "from #{(Time.zone.now - 5.months).strftime('%-e %b %Y')} to present",
            government_position: double(:government_position,
              name: 'Test Government Position Name',
              graph_id:   government_graph_id,
            )
          )
        ],
        'SeatIncumbency'.to_s => [
          double(:seat_incumbency,
            type: '/SeatIncumbency',
            house_of_commons?: true,
            house_of_lords?: false,
            start_date: Time.zone.now - 2.months,
            end_date:   nil,
            date_range: "from #{(Time.zone.now - 4.months).strftime('%-e %b %Y')} to present",
            constituency: double(:constituency,
              name:       'Fake Place 2',
              graph_id:   constituency_graph_id,
            )
          )
        ]
      })

      assign(:sorted_incumbencies, [
        double(:first_incumbency,
          start_date: Time.zone.now - 5.years
        ),
        double(:last_incumbency,
          end_date: Time.zone.now - 1.years
        )
      ])

      render
    end

    it 'will render display name' do
      expect(rendered).to match(/Test Display Name/)
    end

    context 'showing current' do
      context 'Parliamentary roles' do
        it 'will render the correct sub-header' do
          expect(rendered).to match(/Parliamentary role/)
        end

        it 'will render the correct title' do
          expect(rendered).to match(/Fake Place 2/)
        end

        it 'will render start date to present' do
          expect(rendered).to match("#{(Time.zone.now - 4.months).strftime('%-e %b %Y')} to present")
        end
      end

      context 'Committee roles' do
        it 'will render the correct sub-header' do
          expect(rendered).to match(/Committee role/)
        end

        it 'will render the correct title' do
          expect(rendered).to match(/Test Committee Name/)
        end

        it 'will render start date to present' do
          expect(rendered).to match("#{(Time.zone.now - 4.months).strftime('%-e %b %Y')} to present")
        end
      end

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

      context 'Opposition roles' do
        it 'will render the correct sub-header' do
          expect(rendered).to match(/Opposition role/)
        end

        it 'will render the correct title' do
          expect(rendered).to match(/Opposition Role 1/)
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

      context 'Committee roles' do
        it 'will render the correct sub-header' do
          expect(rendered).to match(/Committee role/)
        end

        it 'will render the correct title' do
          expect(rendered).to match(/Second Committee Name/)
        end

        it 'will render start date to present' do
          expect(rendered).to match((Time.zone.now - 8.years).strftime('%-e %b %Y'))
        end

        it 'will render present status' do
          expect(rendered).to match((Time.zone.now - 7.years).strftime('%-e %b %Y'))
        end
      end

      context 'Government roles' do
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

      context 'Opposition roles' do
        it 'will render the correct sub-header' do
          expect(rendered).to match(/Opposition Role 2/)
        end

        it 'will render the correct title' do
          expect(rendered).to match(/Opposition Role 2/)
        end

        it 'will render start date to present' do
          expect(rendered).to match((Time.zone.now - 5.years).strftime('%-e %b %Y'))
        end

        it 'will render present status' do
          expect(rendered).to match((Time.zone.now - 3.years).strftime('%-e %b %Y'))
        end
      end

      context 'Parliamentary roles' do
        it 'will render the correct sub-header' do
          expect(rendered).to match(/Parliamentary role/)
        end

        it 'will render start date to present' do
          expect(rendered).to match((Time.zone.now - 6.months).strftime('%-e %b %Y'))
        end

        it 'will render present status' do
          expect(rendered).to match((Time.zone.now - 1.week).strftime('%-e %b %Y'))
        end
      end
    end

    context 'showing start date' do
        it 'shows start date' do
          expect(rendered).to match((Time.zone.now - 25.years).strftime('%Y'))
        end
      end
  end
end
