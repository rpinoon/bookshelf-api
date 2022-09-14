class Api::UserBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user_book, only: [:destroy, :update, :show]

  def index
    books = UserBooks::QueryService.new({finish_date: params[:finish_date], user: current_user}).search

    render json: serialize_data(books)
  end

  def show
    render json: serialize(@user_book)
  end

  def create
    user_book = current_user.user_books.create(user_book_params)
    if user_book.save
      render json: serialize(user_book)
    else
      render json: {errors: user_book.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @user_book.destroy!
      render json: {}
    else
      render json: {errors: @user_book.errors}, status: :unprocessable_entity
    end
  end


  def update
    if @user_book.update(user_book_params)
      render json: serialize(@user_book)
    else
      render json: {errors: @user_book.errors}, status: :unprocessable_entity
    end
  end
  
  private
  
  def get_user_book
    @user_book = UserBook.find(params[:id])
  end

  def user_book_params 
    params.require(:user_book).permit(:book_id, :rating, :notes, :start_date, :finish_date)
  end

  def serialize_data(data)
    return UserBookSerializer.new(data).serializable_hash[:data].pluck(:attributes)
  end
  
  def serialize(data)
    return UserBookSerializer.new(data).serializable_hash[:data][:attributes]
  end
end 