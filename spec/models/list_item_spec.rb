require 'rails_helper'

RSpec.describe ListItem, type: :model do
  subject {FactoryBot.create(:list_item)}


  context 'list item validations' do
    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a book' do
      subject.book = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a rating' do
      subject.rating = nil
      expect(subject).to_not be_valid
    end

    it 'rating should not be greater than 5' do
      subject.rating = 6
      expect(subject).to_not be_valid
    end

    it 'rating should not be zero' do
      subject.rating = 0
      expect(subject).to_not be_valid
    end

    it 'will create a valid list item' do
      expect(subject).to be_valid
    end
  end

  context 'list item associations' do
    it 'belongs to user' do
      should respond_to(:user)
    end

    it 'belongs to book' do
      should respond_to(:book)
    end
  end

  context 'default values' do
    before do
      user = FactoryBot.create(:user)
      book = FactoryBot.create(:book)
      @list_item = ListItem.create(user_id: user.id, book_id: book.id)
    end

    it 'should have default rating of -1' do
      expect(@list_item.rating).to eq(-1)
    end
    
    it 'should have default start_date of nil' do
      expect(@list_item.start_date).to eq(nil)
    end

    it 'should have default finish_date of nil' do
      expect(@list_item.finish_date).to eq(nil)
    end
  end
end