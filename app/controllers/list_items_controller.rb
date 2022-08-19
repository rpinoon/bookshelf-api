class ListItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_item, except: [:index, :create]

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
      }, status: :ok
    else
      render json: list_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @list_item.destroy!

      render json: {
        status: 200,
        message: 'Successfully removed!',
        list_item: @list_item,
      }, status: :ok
    else
      render json: @list_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @list_item.update(list_item_params)
      render json: {
        status: 200,
        message: 'Successfully updated!',
        list_item: @list_item,
      }, status: :ok
    else
      render json: @list_item.errors, status: :unprocessable_entity
    end
  end

  private
  
  def get_item
    @list_item = ListItem.find(params[:id])
  end

  def list_item_params 
    params.require(:list_item).permit(:user_id, :book_id, :rating, :notes, :start_date, :finish_date)
  end
end
