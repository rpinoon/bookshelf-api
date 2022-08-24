require 'rails_helper'

RSpec.describe UserBook, type: :model do
  subject {FactoryBot.create(:user_book)}


  context 'user book validations' do
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

    it 'rating should not be a negative number' do
      subject.rating = -1
      expect(subject).to_not be_valid
    end

    it 'will create a valid user book' do
      expect(subject).to be_valid
    end
  end

  context 'user book associations' do
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
      @user_book = UserBook.create(user_id: user.id, book_id: book.id)
    end

    it 'should have default rating of 0' do
      expect(@user_book.rating).to eq(0)
    end
    
    it 'should have default start_date of nil' do
      expect(@user_book.start_date).to eq(nil)
    end

    it 'should have default finish_date of nil' do
      expect(@user_book.finish_date).to eq(nil)
    end
  end
end