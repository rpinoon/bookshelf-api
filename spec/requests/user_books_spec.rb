require 'rails_helper'

RSpec.describe Api::UserBooksController, type: :request do
  context 'success cases' do
    before do
      @user = FactoryBot.create(:user)
      sign_in(@user)
  
      @book = FactoryBot.create(:book)
      @book1 = FactoryBot.create(:book)
      @book2 = FactoryBot.create(:book)
  
      @user_book1 = UserBook.create(user_id: @user.id, book_id: @book1.id)
      @user_book2 = UserBook.create(user_id: @user.id, book_id: @book2.id, start_date: Time.now, finish_date: Time.now)
    end
  
    it 'returns index of user_books' do
      get '/api/user_books'
      json = JSON.parse(response.body)
  
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:success)
      expect(json.length).to eq(2)
    end
  
    it 'returns a specific user_book' do
      get "/api/user_books/#{@user_book2.id}"
      json = JSON.parse(response.body)
  
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:success)
      expect(Date.parse(json['start_date'])).to eq(@user_book2.start_date)
      expect(json['rating']).to eq(@user_book2.rating)
    end
  
    it 'creates a user_book entry' do
      post '/api/user_books', params: { user_book: { 
        user_id: @user.id,
        book_id: @book.id
       } }
  
      json = JSON.parse(response.body)
  
      expect(json["status"]).to eq(201)
      expect(json["message"]).to eq('Successfully created!')
    end
  
    it 'removes a user_book' do
      delete "/api/user_books/#{@user_book1.id}"
  
      json = JSON.parse(response.body)
      expect(json["status"]).to eq(200)
      expect(json["message"]).to eq('Successfully removed!')
    end
  
    it 'marks a user_book as read' do
      patch "/api/user_books/#{@user_book2.id}", params: { user_book: { finish_date: Time.now } }
  
      json = JSON.parse(response.body)
      expect(json["status"]).to eq(200)
      expect(json["message"]).to eq('Successfully updated!')
    end
  
    it 'marks a user_book as unread' do
      patch "/api/user_books/#{@user_book2.id}", params: { user_book: { finish_date: nil } }
  
      json = JSON.parse(response.body)
      expect(json["status"]).to eq(200)
      expect(json["message"]).to eq('Successfully updated!')
    end
  
    it 'updates the rating of a user_book' do
      patch "/api/user_books/#{@user_book1.id}", params: { user_book: { rating: 2 } }
  
      json = JSON.parse(response.body)
      
      expect(json["status"]).to eq(200)
      expect(json["message"]).to eq('Successfully updated!')
      expect(json['user_book']['rating']).to eq(2)
    end
  
    it 'updates the notes of a user_book' do
      patch "/api/user_books/#{@user_book1.id}", params: { user_book: { notes: "This is a good read" } }
  
      json = JSON.parse(response.body)
      expect(json["status"]).to eq(200)
      expect(json["message"]).to eq('Successfully updated!')
      expect(json['user_book']['notes']).to eq("This is a good read")
    end
  
    it 'shows all books marked to be read' do
      get "/api/to_read"
      json = JSON.parse(response.body)
  
      expect(json["status"]).to eq(200)
      expect(json["user"]["id"]).to eq(@user.id)
      expect(json["list"][0]["book_id"]).to eq(@book1.id)
    end
  
    it 'shows all books marked as finished' do
      get "/api/finished"
      json = JSON.parse(response.body)

      expect(json["status"]).to eq(200)
      expect(json["user"]["id"]).to eq(@user.id)
      expect(json["list"][0]["book_id"]).to eq(@book2.id)
    end
  end

  context 'fail cases' do
    before do
      @book_less_user = FactoryBot.create(:user)
      sign_in @book_less_user

      @book = FactoryBot.create(:book)
      @user_book = FactoryBot.create(:user_book)
    end

    
    it 'will notify if reading list is empty' do
      get "/api/to_read"
      json = JSON.parse(response.body)

      expect(json["status"]).to eq(404)
      expect(json["message"]).to eq('The reading list is still empty')
    end
  
    it 'will notify if finished list is empty' do
      get "/api/finished"
      json = JSON.parse(response.body)
  
      expect(json["status"]).to eq(404)
      expect(json["message"]).to eq("You haven't finished any books yet")
    end

    it 'will not duplicate if user already has the book' do
      UserBook.create(user_id: @book_less_user.id, book_id: @book.id)

      expect {UserBook.create(user_id: @book_less_user.id, book_id: @book.id).to raise_error(ActiveRecord::RecordNotUnique)}
      # post '/api/user_books', params: { user_book: { 
      #   user_id: @book_less_user.id,
      #   book_id: @book.id
      #  } }
      #  json = JSON.parse(response.body)
      #   debugger
      #  expect(response).to have_http_status(:unprocessable_entity)
      #  expect(json[0]).to eq("Book has already been taken")
    end

    it 'will not update with incorrect rating value' do
      patch "/api/user_books/#{@user_book.id}", params: { user_book: { rating: 6 } }
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json[0]).to eq("Rating is not included in the list")
    end
  end
end
