class BookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :book_id, :title, :author, :cover_image_url, :publisher, :synopsis
end
