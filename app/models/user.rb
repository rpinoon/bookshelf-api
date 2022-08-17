class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :jwt_authenticatable, jwt_revocation_strategy: self, :authentication_keys => [:username]
  
  has_many :list_items
  has_many :books, through: :list_items
  
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
end
