require 'rails_helper'

RSpec.describe Book, type: :model do
  subject { FactoryBot.create(:book) }

  context 'book validations' do
    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an author' do
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a publisher' do
      subject.publisher = nil
      expect(subject).to_not be_valid
    end

    it 'will create a valid book' do
      expect(subject).to be_valid
    end
  end

  context 'book associations' do
    it 'has many users through list items' do
      should respond_to(:users)
    end

    it 'has many list items' do
      should respond_to(:list_items)
    end
  end
end
