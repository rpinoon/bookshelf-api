class Api::BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_book, except: [:index, :discover]

  def index
    books = Book.all
    render json: BookSerializer.new(books).serializable_hash[:data].pluck(:attributes)
  end

  def show
    render json: @book
  end

  def discover
    id_array = current_user.user_books.pluck(:book_id)
    books = Book.where.not(id: id_array)

    render json: books
  end

  private

  def get_book
    @book = Book.find(params[:id])
  end
end