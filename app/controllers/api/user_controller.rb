# frozen_string_literal: true

module Api
  class UserController < ApplicationController
    before_action :authenticate_user!
    def index
      render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
    end
  end
end
