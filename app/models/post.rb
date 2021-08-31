class Post < ApplicationRecord
  mount_uploader :illustration, ImageUploader
  belongs_to :user
  validates :illustration, presence: true
  validates :description, presence: true
end
