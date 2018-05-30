require 'rails_helper'

RSpec.describe 'work_packages/index', vcr: true do
  let!(:work_packages) {
    assign(:work_packages, [work_package])
  }

  let!(:work_package) {
    assign(:work_package,
      double(:work_package,
        work_packageable_thing_name: 'Work Packageable Thing',
        graph_id: 'g57cvhtr',
        oldest_business_item_date: DateTime.new(2018, 05, 10),
        procedure: double(:procedure,
          name: 'Procedure Name 1'
        )
      )
    )
  }

  before do
    render
  end

  context 'header' do
    it 'will render the correct header' do
      expect(rendered).to match(/Work packages/)
    end
  end

  context 'work packageable thing' do
    context 'with data' do
      it 'will render name' do
        expect(rendered).to have_link('Work Packageable Thing', href: work_package_path('g57cvhtr'))
      end

      it 'does not display empty list content' do
        expect(rendered).not_to match(/There are no results/)
      end

      context 'with an oldest business item date' do
        it 'renders date' do
          expect(rendered).to match(/10 May 2018/)
        end
      end

      context 'without an oldest business item date' do
        let!(:work_package) {
          assign(:work_package,
            double(:work_package,
              work_packageable_thing_name: 'Work Packageable Thing',
              graph_id: 'g57cvhtr',
              oldest_business_item_date: nil,
              procedure: double(:procedure,
                name: 'Procedure Name 1'
              )
            )
          )
        }
        it 'does not render date' do
          expect(rendered).not_to match(/10 May 2018/)
        end
      end

      context 'with a procedure name' do
        it 'will render procedure name with correct capitalisation' do
          expect(rendered).to match(/Procedure name 1/)
        end
      end

      context 'without a procedure name' do
        let!(:work_package) {
          assign(:work_package,
            double(:work_package,
              work_packageable_thing_name: 'Work Packageable Thing',
              graph_id: 'g57cvhtr',
              oldest_business_item_date: DateTime.new(2018, 05, 10),
              procedure: nil
            )
          )
        }

        it 'does not render procedure name' do
          expect(rendered).not_to match(/Procedure name 1/)
        end
      end
    end
  end

  context 'without data' do
    let!(:work_packages) { assign(:work_packages, []) }

    it 'displays empty list content' do
      expect(rendered).to match(/There are no results/)
    end
  end
end
