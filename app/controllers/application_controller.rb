class ApplicationController < ActionController::API
  rescue_from StandardError, with: :display_error

  private

  def display_error(e)
    render json: { error: e }, status: :unprocessable_entity
  end
end
