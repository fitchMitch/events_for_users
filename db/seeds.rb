# frozen_string_literal: true

FactoryBot.create(:event)
3.times do
  FactoryBot.create(:event_with_users)
end
