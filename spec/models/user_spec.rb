require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }
  second_user = FactoryBot.create(:user)

  context 'user validations' do
    it 'is not valid without a username' do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'password should have 6 characters min' do
      subject.password = 'passw'
      expect(subject).to_not be_valid
    end

    it 'username should be unique' do
      second_user.username = subject.username
      expect(second_user).to_not be_valid
    end

    it 'will create a valid user' do
      expect(subject).to be_valid
    end
  end

  context 'user associations' do
    it 'has many books through list items' do
      should respond_to(:books)
    end

    it 'has many user books' do
      should respond_to(:user_books)
    end
  end
end
