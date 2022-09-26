# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books

  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :cover_image_url, presence: true
end
