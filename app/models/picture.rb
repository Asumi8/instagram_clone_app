class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 500 }

  has_many :favorites, dependent: :destroy 
  has_many :favorite_users, through: :favorites, source: :user
end
