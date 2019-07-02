require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:firstname) }
  it { should validate_length_of(:firstname).is_at_least(2) }
  it { should validate_length_of(:firstname).is_at_most(50) }

  it { should validate_presence_of(:lastname) }
  it { should validate_length_of(:lastname).is_at_least(2) }
  it { should validate_length_of(:lastname).is_at_most(50) }

  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(255) }

  it { should allow_value('eric').for(:firstname) }
  it { should allow_value('BICONE').for(:lastname) }
  it { should allow_value('gogo@lele.fr').for(:email) }

end
