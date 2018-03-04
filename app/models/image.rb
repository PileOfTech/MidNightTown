class Image < ApplicationRecord
  validates :image, :pack_id, presence: true
  belongs_to :pack
  mount_uploader :image, ImageUploader
end
