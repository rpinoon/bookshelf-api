# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :jwt_authenticatable, jwt_revocation_strategy: self, authentication_keys: [:username]

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
