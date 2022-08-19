require 'rails_helper'

RSpec.describe "ListItems", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in(@user)
    @book = FactoryBot.create(:book)

    @list1 = FactoryBot.create(:list_item)
    @list2 = FactoryBot.create(:list_item)
    @list3 = FactoryBot.create(:list_item)
  end

  it 'returns all list items' do
    get '/list'
    json = JSON.parse(response.body)

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:success)
    expect(json.length).to eq(3)
  end

  it 'returns a specific book' do
    get '/list_item', params: { id: @list3.id }
    json = JSON.parse(response.body)

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:success)
    expect(json['start_date']).to eq(@list3.start_date)
    expect(json['rating']).to eq(@list3.rating)
  end

  it 'creates a list item' do
    post '/list_item', params: { list_item: { 
      user_id: @user.id,
      book_id: @book.id
     } }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(201)
    expect(json["message"]).to eq('Successfully created!')
  end

  it 'removes a list item' do
    delete '/list_item', params: { list_item_id: @list1.id }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(201)
    expect(json["message"]).to eq('Successfully removed!')
  end

  it 'marks a list item as read' do
    patch '/list_item', params: { list_item: { finish_date: Time.now } }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(201)
    expect(json["message"]).to eq('Marked as read!')
  end

  it 'marks a list item as unread' do
    patch '/list_item', params: { list_item: { finish_date: nil } }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(201)
    expect(json["message"]).to eq('Marked as unread!')
  end

  it 'updates the rating of a list item' do
    patch '/list_item', params: { list_item: { rating: 2 } }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(201)
    expect(json["message"]).to eq('Updated rating!')
  end
end
