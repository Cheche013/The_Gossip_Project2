class User < ApplicationRecord
  belongs_to :city, optional: true
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
   has_many :gossips,  dependent: :nullify  
  has_many :comments, dependent: :nullify
   has_many :likes,    dependent: :destroy 
end
