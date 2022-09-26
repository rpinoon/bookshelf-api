# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)

    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
    @book3 = FactoryBot.create(:book)
  end

  it 'returns all books' do
    get '/api/books'
    json = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(:success)
    expect(json.length).to eq(3)
  end

  it 'returns a specific book' do
    get '/api/book', params: { id: @book2.id }
    json = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(:success)
    expect(json['title']).to eq(@book2.title)
    expect(json['author']).to eq(@book2.author)
  end

  it 'returns all unread books' do
    UserBook.create(user_id: @user.id, book_id: @book3.id)

    get '/api/discover'
    json = JSON.parse(response.body)

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(:success)
    expect(json).not_to include(@book3)
  end
end
