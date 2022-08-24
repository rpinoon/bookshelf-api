class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private

  def respond_with(resource, _opts = {})
    render json: { data: UserSerializer.new(resource).serializable_hash[:data][:attributes] }
  end

  def respond_to_on_destroy
    render json: {
      errors: resource.errors
    }, status: :unprocessable_entity
  end
end