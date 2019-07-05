# frozen_string_literal: true

# FactoryBot for events
FactoryBot.define do
  factory :event do
    title               { ((Faker::Lorem.words 3).join ' ').truncate 50 }
    description         { (Faker::Lorem.sentence 15).truncate 150 }
    location            { Faker::Address.full_address }
    start_time          { Time.zone.now + (-10..9).to_a.sample.days +
                                          (0..23).to_a.sample.hours }
    end_time            { start_time + (0..18_400).to_a.sample.seconds }

    factory :event_with_users do
      transient do
        users_qty { 4 }
      end
      after(:create) do |event, evaluator|
        create_list(:user, evaluator.users_qty, events: [event])
      end
    end
  end
end
