class UserBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user_book, only: [:destroy, :update, :show]
  before_action :get_reading_list, only: [:to_read]
  before_action :get_finished_list, only: [:finished]

  def index
    user_books = UserBook.all
    render json: user_books
  end

  def show
    render json: @user_book
  end

  def create
    user_book = UserBook.create(user_book_params)
    if user_book.save
      render json: {
        status: 201,
        message: 'Successfully created!',
        user_book: user_book,
      }
    else
      render json: user_book.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @user_book.destroy!

      render json: {
        status: 200,
        message: 'Successfully removed!',
        user_book: @user_book,
      }
    else
      render json: @user_book.errors.full_messages, status: :unprocessable_entity
    end
  end


  def update
    if @user_book.update(user_book_params)
      render json: {
        status: 200,
        message: 'Successfully updated!',
        user_book: @user_book,
      }
    else
      render json: @user_book.errors.full_messages, status: :unprocessable_entity
    end
  end

  def to_read
    if @reading_list.empty?
      render json: {
        status: 404,
        message: 'The reading list is still empty'
      }
    else
      id_array = @reading_list.pluck(:book_id)
      books = Book.where(id: id_array)

      render json: {
        status: 200,
        user: current_user,
        list: @reading_list,
        books: books
      }
    end 
  end

  def finished
    if @finished_list.empty?
      render json: {
        status: 404,
        message: "You haven't finished any books yet"
      }
    else
      id_array = @finished_list.pluck(:book_id)
      books = Book.where(id: id_array)

      render json: {
        status: 200,
        user: current_user,
        list: @finished_list,
        books: books
      }
    end
  end
  
  private
  
  def get_user_book
    @user_book = UserBook.find(params[:id])
  end

  def user_book_params 
    params.require(:user_book).permit(:user_id, :book_id, :rating, :notes, :start_date, :finish_date)
  end

  def get_reading_list
    @reading_list = current_user.user_books.where(finish_date: nil)
  end

  def get_finished_list
    @finished_list = current_user.user_books.where.not(finish_date: nil)
  end
end