class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :rating, presence: true, inclusion: 0..5

  scope :to_read, ->(user) { Book.where(id: where(finish_date: nil, user_id: user).pluck(:book_id)) }
  scope :finished, ->(user) { Book.where(id: where.not(finish_date: nil, user_id: user).pluck(:book_id))}
end
