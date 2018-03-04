class Genre < ApplicationRecord
  has_many :packs
  mount_uploader :cover, ImageUploader
end
