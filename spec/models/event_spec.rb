require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { build(:event) }

  it { have_and_belong_to_many :users  }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(50) }

  it { should validate_length_of(:description).is_at_most(150) }

  it { should validate_presence_of(:location) }
  it { should validate_length_of(:location).is_at_most(120) }

  describe '.list' do
    before do
      3.times do |n|
        create(:event_with_users, users_count: 2)
      end
    end
    subject { described_class.list }
    it { expect(subject.to_a.count).to eq 3 }
    it { expect(subject.to_a.inject(0) { |sum, evt|
      sum + evt.user_count.to_i}).to eq 6
    }
  end

  describe '.search_location' do
    let!(:event) { create(:event, location:'19 rue du Louvre,75603 Paris') }
    context 'when at least a location is found' do
      it { expect(described_class.search_location('Louvre')).to eq [event] }
      it { expect(described_class.search_location('Lou')).to eq [event] }
      it { expect(described_class.search_location('louvre')).to eq [event] }
      it { expect(described_class.search_location('Loua')).to eq [] }
      it { expect(described_class.search_location('Louvres')).to eq [] }
    end
  end

  describe '.search_by_title_or_description' do
    context 'when at least a title is found' do
      let!(:event) { create(:event, title:'Au Louvre', description: 'aaaaaaaa') }
      it { expect(described_class.search_by_title_or_description('lou')).to eq [event] }
      it { expect(described_class.search_by_title_or_description('LouV')).to eq [event] }
      it { expect(described_class.search_by_title_or_description('LouVa')).to eq [] }
    end
    context 'when at least a description is found' do
      let!(:event) { create(:event, title:'AG', description: 'le Louvre, c\'est bien') }
      it { expect(described_class.search_by_title_or_description('lou')).to eq [event] }
      it { expect(described_class.search_by_title_or_description('LouV')).to eq [event] }
      it { expect(described_class.search_by_title_or_description('LouVa')).to eq [] }
    end

    describe '.between_dates' do
      let!(:that_time) { Time.zone.iso8601('1999-12-31T14:00:00') }
      # let(:zone) { double('zone') }
      # before do
      #   allow(Time).to receive(:zone) { zone }
      #   allow(zone).to receive(:now) { that_time }
      # end
      let(:date_way_before) { that_time - 16.hours }
      let(:date_way_after) { that_time + 16.hours }
      let!(:event_way_before) { create(:event, start_time: date_way_before, end_time: date_way_before + 1.hours) }
      let!(:event_just_in) { create(:event, start_time: that_time, end_time: that_time + 1.hour) }
      let!(:event_way_after) { create(:event, start_time: date_way_after, end_time: date_way_after + 1.hour) }

      context 'when time window is large' do
        let(:t_start) { that_time - 17.hours }
        let(:t_end) { that_time + 17.hours }
        it { expect(described_class.between_dates(t_start, t_end).count).to eq(3) }
      end
      context 'when time window is narrow' do
        let(:t_start) { that_time - 2.hours }
        let(:t_end) { that_time + 2.hours }
        it { expect(described_class.between_dates(t_start, t_end).count).to eq(1) }
      end
      context 'when time window is off before' do
        let(:t_start) { that_time - 17.hours }
        let(:t_end) { t_start + 90.minutes }
        it { expect(described_class.between_dates(t_start, t_end).count).to eq(0) }
      end
      context 'when time window is off after' do
        let(:t_start) { that_time + 15.hours + 30.minutes }
        let(:t_end) { t_start + 61.minutes }
        it { expect(described_class.between_dates(t_start, t_end).count).to eq(0) }
      end
    end

    # private

    describe '#begin_set_before_after?' do
      context 'when start_time is blanck' do
        let(:event) do
          create(
            :event,
            start_time: nil,
            end_time: 2.hours.ago
          )
        end
        it { expect{event.begin_set_before_after?}.to raise_error(ActiveRecord::NotNullViolation)  }
      end
      context 'when end_time is blanck' do
        let(:event) do
          create(
            :event,
            end_time: nil,
            start_time: 2.hours.ago
          )
        end
        it { expect{event.begin_set_before_after?}.to raise_error(ActiveRecord::NotNullViolation)  }
      end
      context 'when start_time is set before end_time' do
        let(:event) { build(:event, start_time: Time.zone.now, end_time: 1.day.ago) }
        let(:error_message) do
          { end_time: ["Your meeting have to finish after its beginning"] }
        end
        it { expect(event.send(:begin_set_before_after?)).to eq(error_message[:end_time]) }
      end
      context 'when start_time is set before end_time' do
        let(:event) { create(:event, start_time: 1.day.ago, end_time: Time.zone.now) }
        it { expect(event.send(:begin_set_before_after?)).to be(nil)  }
      end
    end
  end


end
