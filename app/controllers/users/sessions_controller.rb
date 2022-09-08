class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private

  def respond_with(resource, _opts = {})
    render json: UserSerializer.new(resource).serializable_hash[:data][:attributes]
  end

  def respond_to_on_destroy
    render json: {
      message: "logged out successfully"
    }, status: 200
  end
end