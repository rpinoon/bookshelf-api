require 'rails_helper'

RSpec.describe User, type: :request do
  context 'user signup authentication' do

    it 'will not sign up without username' do
      post '/signup', params: { user: { username: '', password: 'password' } }

      json = JSON.parse(response.body)

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['status']['message']).to eq("User couldn't be created successfully. Username can't be blank")
    end

    it 'will not sign up without password' do
      post '/signup', params: { user: { username: 'username', password: '' } }

      json = JSON.parse(response.body)

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['status']['message']).to eq("User couldn't be created successfully. Password can't be blank and Password is too short (minimum is 6 characters)")
    end

    it 'will not sign up if password is less than 6 characters' do
      post '/signup', params: { user: { username: 'username', password: 'passw' } }

      json = JSON.parse(response.body)

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json['status']['message']).to eq("User couldn't be created successfully. Password is too short (minimum is 6 characters)")
    end
    
    it 'will sign up with correct details' do
      post '/signup', params: { user: { username: 'username', password: 'password' } }

      json = JSON.parse(response.body)

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:success)
      expect(json['status']['message']).to eq("Signed up sucessfully.")
    end
  end

  context 'users login/logout authentication' do
    before do
      @valid_user = FactoryBot.create(:user)
    end

    it 'will not login with incorrect username' do
      post '/login', params: {user: {username: 'different', password: @valid_user.password}}

      expect(response).to have_http_status(:unauthorized)
    end

    it 'will not login with incorrect password' do
      post '/login', params: {user: {username: @valid_user.username, password: 'incorrect'}}

      expect(response).to have_http_status(:unauthorized)
    end

    it 'will login with correct credentials' do
      post '/login', params: {user: {username: @valid_user.username, password: @valid_user.password}}

      expect(response).to have_http_status(:success)
    end

    it 'will allow a verified user to logout' do
      delete '/logout'

      expect(response).to have_http_status(:success)
    end
  end
end