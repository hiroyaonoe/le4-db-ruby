FactoryBot.define do
  factory :board do
    sequence(:title) { |n| "Board#{n}" }
    user
    category
  end
end
