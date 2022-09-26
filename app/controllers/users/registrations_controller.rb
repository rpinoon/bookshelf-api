# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      if resource.persisted?
        render json: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      else
        render json: {
          errors: resource.errors
        }, status: :unprocessable_entity
      end
    end
  end
end
