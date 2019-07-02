require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { build(:event) }

  it { have_and_belong_to_many :users  }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(50) }

  it { should validate_length_of(:description).is_at_most(150) }

  it { should validate_presence_of(:location) }
  it { should validate_length_of(:location).is_at_most(120) }

  it { should validate_presence_of(:start_time) }

  it { should validate_presence_of(:sec_duration) }
  it { should validate_numericality_of(:sec_duration) }
  it { expect(event.sec_duration).to be >= 0 }


end
