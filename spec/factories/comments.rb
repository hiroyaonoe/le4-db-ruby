FactoryBot.define do
  factory :comment do
    content {"Comment1"}
    user
    board
  end
end
