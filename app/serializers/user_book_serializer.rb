class UserBookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_book_id, 
              :user_id, 
              :book_id, 
              :rating, 
              :notes, 
              :start_date, 
              :finish_date, 
              :author, 
              :publisher, 
              :cover_image_url, 
              :title,
              :synopsis
  belongs_to :book
end