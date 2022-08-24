class Api::UserBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user_book, only: [:destroy, :update, :show]

  def index
    books = params[:finish_date] == nil ? UserBook.to_read(current_user) : UserBook.finished(current_user)
    if books.empty?
      render json: {errors: "List is empty"}, status: :unprocessable_entity
    else
      options = { include: [:book] }
      render json: UserBookSerializer.new(books, options).serializable_hash
    end
  end

  def show
    render json: @user_book
  end

  def create
    user_book = current_user.user_books.create(user_book_params)
    if user_book.save
      render json: {
        message: 'Successfully created!',
        user_book: user_book,
      }
    else
      render json: {errors: user_book.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @user_book.destroy!
      render json: {
        message: 'Successfully removed!',
      }
    else
      render json: {errors: @user_book.errors.full_messages}, status: :unprocessable_entity
    end
  end


  def update
    if @user_book.update(user_book_params)
      render json: {
        message: 'Successfully updated!',
        user_book: @user_book,
      }
    else
      render json: {errors: @user_book.errors.full_messages}, status: :unprocessable_entity
    end
  end
  
  private
  
  def get_user_book
    @user_book = UserBook.find(params[:id])
  end

  def user_book_params 
    params.require(:user_book).permit(:book_id, :rating, :notes, :start_date, :finish_date)
  end
end