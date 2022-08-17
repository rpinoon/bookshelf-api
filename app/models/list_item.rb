class ListItem < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, uniqueness: true
  validates :rating, presence: true, inclusion: { in: [-1, 1, 2, 3, 4, 5] }
end
