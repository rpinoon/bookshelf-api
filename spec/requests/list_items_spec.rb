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
    get '/list_items'
    json = JSON.parse(response.body)

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:success)
    expect(json.length).to eq(3)
  end

  it 'returns a specific list_item' do
    get "/list_items/#{@list3.id}"
    json = JSON.parse(response.body)

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:success)
    expect(Date.parse(json['start_date'])).to eq(@list3.start_date)
    expect(json['rating']).to eq(@list3.rating)
  end

  it 'creates a list item' do
    post '/list_items', params: { list_item: { 
      user_id: @user.id,
      book_id: @book.id
     } }

    json = JSON.parse(response.body)

    expect(json["status"]).to eq(201)
    expect(json["message"]).to eq('Successfully created!')
  end

  it 'removes a list item' do
    delete "/list_items/#{@list1.id}"

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(200)
    expect(json["message"]).to eq('Successfully removed!')
  end

  it 'marks a list item as read' do
    patch "/list_items/#{@list2.id}", params: { list_item: { finish_date: Time.now } }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(200)
    expect(json["message"]).to eq('Successfully updated!')
  end

  it 'marks a list item as unread' do
    patch "/list_items/#{@list2.id}", params: { list_item: { finish_date: nil } }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(200)
    expect(json["message"]).to eq('Successfully updated!')
  end

  it 'updates the rating of a list item' do
    patch "/list_items/#{@list1.id}", params: { list_item: { rating: 2 } }

    json = JSON.parse(response.body)
    
    expect(json["status"]).to eq(200)
    expect(json["message"]).to eq('Successfully updated!')
    expect(json['list_item']['rating']).to eq(2)
  end

  it 'updates the notes of a list item' do
    patch "/list_items/#{@list1.id}", params: { list_item: { notes: "This is a good read" } }

    json = JSON.parse(response.body)
    expect(json["status"]).to eq(200)
    expect(json["message"]).to eq('Successfully updated!')
    expect(json['list_item']['notes']).to eq("This is a good read")
  end
end
