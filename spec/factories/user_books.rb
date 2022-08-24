FactoryBot.define do
  factory :user_book do
    user
    book
    rating { Faker::Number.between(from: 1, to: 5) }
    notes { "sample note" }
    start_date { Time.now }
    finish_date { Time.now }
  end
end
