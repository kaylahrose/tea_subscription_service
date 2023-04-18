FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.number(digits: 3) }
    brew_time { Faker::Number.number(digits: 1)}
  end
end