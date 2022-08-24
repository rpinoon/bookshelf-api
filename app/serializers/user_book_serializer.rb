class UserBookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :book_id, :rating, :notes, :start_date, :finish_date
  belongs_to :book
end
