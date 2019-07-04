require 'rails_helper'

RSpec.feature 'Event' do
  feature 'as a registered admin' do
    feature 'visiting INDEX' do
      background :each do
        3.times { create(:event) }
        visit events_path
      end
      it 'should list 3 events' do
        expect(page.body).to have_selector('.event-desc', count: 3)
      end
      it 'should list the event\'s band members' do
        expect(page.body).to have_selector('h1', text: 'Events')
        expect(page.body).to have_selector('h2', text: 'Events list')
      end
    end

    feature 'filtering by location' do
      feature 'with no input' do
        background do
          3.times { create(:event) }
          visit events_path
          click_button('Search')
        end
        it { expect(page.body).to have_selector('.event-desc', count: 3) }
      end
      feature 'with  input' do
        background do
          create(:event, location: 'aaaaa')
          create(:event, location: 'bbbb')
          create(:event, location: 'cccc')
          visit events_path
          within '#search_form' do
            fill_in 'search[location]', with: 'aa'
          end
          click_button('Search')
        end
        it { expect(page.body).to have_selector('.event-desc', count: 1) }
      end
    end

    feature 'filtering by title_or_description' do
      before :each do
        create(:event, title:'zzz', description: 'aaaaa')
        create(:event, title:'eee', description: 'bbbb')
        create(:event, title:'bbb', description: 'cccc')
      end
      feature 'with no input' do
        background do
          visit events_path
          click_button('Search')
        end
        it { expect(page.body).to have_selector('.event-desc', count: 3) }
      end
      feature 'with  input description targeted search' do
        background do

          visit events_path
          within '#search_form' do
            fill_in 'search[title_or_description]', with: 'aa'
          end
          click_button('Search')
        end
        it { expect(page.body).to have_selector('.event-desc', count: 1) }
      end
      feature 'with input bb' do
        background do
          visit events_path
          within '#search_form' do
            fill_in 'search[title_or_description]', with: 'bb'
          end
          click_button('Search')
        end
        it { expect(page.body).to have_selector('.event-desc', count: 2) }
      end
      feature 'with input title targeted search' do
        background do
          visit events_path
          within '#search_form' do
            fill_in 'search[title_or_description]', with: 'zz'
          end
          click_button('Search')
        end
        it { expect(page.body).to have_selector('.event-desc', count: 1) }
      end
    end
  end
end
