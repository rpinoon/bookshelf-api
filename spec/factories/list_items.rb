FactoryBot.define do
  factory :list_item do
    user
    book
    rating { -1 }
    notes { "sample note" }
    start_date { "2022-08-17 17:59:58" }
    finish_date { "2022-08-17 17:59:58" }
  end
end
