class Pack < ApplicationRecord
  validates :name, :description, :cover, :genre_id, presence: true
  mount_uploader :cover, ImageUploader
  belongs_to :genre
  has_many :images
end
