json.extract! @pack, :id, :name, :cover, :created_at
json.images @pack.images.order(created_at: :desc)
