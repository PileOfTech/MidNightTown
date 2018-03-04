class Image < ApplicationRecord
  validates :image, :pack_id, presence: true
  belongs_to :autor
  mount_uploader :image, ImageUploader
end
