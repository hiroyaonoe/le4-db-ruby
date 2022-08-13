FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "Comment#{n}" }
    user
    board
  end
end
