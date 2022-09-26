# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    cover_image_url { Faker::Internet.url }
    page_count { Faker::Number.number(digits: 3) }
    publisher { Faker::Book.publisher }
    synopsis { Faker::Lorem.paragraph }
  end
end
