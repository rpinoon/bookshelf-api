class ListItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_item, only: [:destroy, :update, :show]
  before_action :get_reading_list, only: [:to_read]
  before_action :get_finished_list, only: [:finished]

  def index
    list_items = ListItem.all
    render json: list_items
  end

  def show
    render json: @list_item
  end

  def create
    list_item = ListItem.create(list_item_params)
    if list_item.save
      render json: {
        status: 201,
        message: 'Successfully created!',
        list_item: list_item,
      }
    else
      render json: list_item.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @list_item.destroy!

      render json: {
        status: 200,
        message: 'Successfully removed!',
        list_item: @list_item,
      }
    else
      render json: @list_item.errors.full_messages, status: :unprocessable_entity
    end
  end


  def update
    if @list_item.update(list_item_params)
      render json: {
        status: 200,
        message: 'Successfully updated!',
        list_item: @list_item,
      }
    else
      render json: @list_item.errors.full_messages, status: :unprocessable_entity
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
  
  def get_item
    @list_item = ListItem.find(params[:id])
  end

  def list_item_params 
    params.require(:list_item).permit(:user_id, :book_id, :rating, :notes, :start_date, :finish_date)
  end

  def get_reading_list
    @reading_list = current_user.list_items.where(finish_date: nil)
  end

  def get_finished_list
    @finished_list = current_user.list_items.where.not(finish_date: nil)
  end
end