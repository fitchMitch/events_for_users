require 'rails_helper'

RSpec.describe EventsController, type: :request do
  let!(:event) { create(
    :event,
    location: 'testimonial',
    title: 'magnum',
    description: 'x' * 10,
    start_time: Time.zone.now,
    end_time: Time.zone.now + 1.hour
    )
  }
  let!(:event_2) { create(
    :event,
    location: 'matrimonial',
    title: 'petitum',
    description: 'y' * 10,
    start_time: Time.zone.now - 2.days,
    end_time: Time.zone.now - 2.days + 1.hour
    )
  }
  describe '#index' do
    context 'with no parameter ' do
      it "renders events index" do
        get '/events'
        expect(response).to render_template (:index)
        expect(assigns(:events).to_a.count).to eq(2)
      end
    end
    context 'with location' do
      it "renders events index" do
        get '/events', params: { search: { location: 'test'}}
        expect(assigns(:events).to_a.count).to eq(1)
      end
    end
    context 'with title' do
      it "renders events index" do
        get '/events', params: { search: { title_or_description: 'magn'}}
        expect(assigns(:events).to_a.count).to eq(1)
      end
    end
    context 'with title and no match' do
      it "renders events index" do
        get '/events', params: { search: { title_or_description: 'magnet'}}
        expect(assigns(:events).to_a.count).to eq(0)
      end
    end
  end

  describe '#search_by_location' do
    it "returns events by location : test with monial" do
      get '/search_by_location',  params: { location: 'monial'}
      expect(assigns(:events).to_a.count).to eq(2)
    end
    it "returns events by location : test with test" do
      get '/search_by_location',  params: { location: 'test'}
      expect(assigns(:events).to_a.count).to eq(1)
    end
  end

  describe '#search_by_title_or_description' do
    it "returns events by title or description : test with mag" do
      get '/search_by_title_or_description',
          params: { title_or_description: 'mag'}
      expect(assigns(:events).to_a.count).to eq(1)
    end
    it "returns events by by title or description : test with fra" do
      get '/search_by_title_or_description',
          params: { title_or_description: 'fra'}
      expect(assigns(:events).to_a.count).to eq(0)
    end
  end

  describe '#date_filter' do
    it "returns events by title or description : test with large window" do
      get '/date_filter',  params: {
        start_date: Time.zone.now-3.days,
        end_date: Time.zone.now + 3.days
      }
      expect(assigns(:events).to_a.count).to eq(2)
    end
    it "returns events by by title or description : test with fra" do
      get '/date_filter',  params: {
        start_date: Time.zone.now-3.days,
        end_date: Time.zone.now
      }
      expect(assigns(:events).to_a.count).to eq(1)
    end
    it "returns events by by title or description : test with fra" do
      get '/date_filter'
      expect(assigns(:events).to_a.count).to eq(2)
    end
  end
end
