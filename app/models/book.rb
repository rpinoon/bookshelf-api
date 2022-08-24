class Book < ApplicationRecord
  has_many :list_items, dependent: :destroy
  has_many :users, through: :list_items

  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
end