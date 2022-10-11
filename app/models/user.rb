class User < ApplicationRecord
  mount_uploader :image, ImageUploader

  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password 
  validates :password, length: { minimum: 6 }
  validates :image, presence: true
  
  has_many :pictures
  
  has_many :favorites, dependent: :destroy 
  has_many :favorite_pictures, through: :favorites, source: :picture #sourceの先はモデル名
end
