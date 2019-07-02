require 'rails_helper'

RSpec.describe User, type: :model do
  it { have_and_belong_to_many :events  }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2) }
  it { should validate_length_of(:name).is_at_most(50) }


end
