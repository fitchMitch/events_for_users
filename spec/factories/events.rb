FactoryBot.define do
  factory :event do
    title               { ((Faker::Lorem.words(3)).join(' ')).truncate(50) }
    description         { (Faker::Lorem.sentence(1)).truncate(150) }
    location            { Faker::Address.full_address }
    start_time          { Time.zone.now +
                          (-10..10).to_a.sample.days +
                          (-12..12).to_a.sample.hours
                        }
    sec_duration        { (0..18400).to_a.sample }

    factory :event_with_users do
      transient do
        users_count { 4 }
      end
      after(:create) do |event, evaluator|
        create_list(:user, evaluator.users_count, events: [event])
      end
    end
  end
end
