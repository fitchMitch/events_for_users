FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    factory :user_with_events do
      transient do
        events_count { 2 }
      end
      after(:create) do |user, evaluator|
        create_list(:event, evaluator.events_count, users: [user])
      end
    end
  end
end
