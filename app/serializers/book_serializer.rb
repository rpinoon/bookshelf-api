class BookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :author, :cover_image_url, :publisher, :synopsis
end
