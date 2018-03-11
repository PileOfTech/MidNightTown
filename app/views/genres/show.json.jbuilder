json.extract! @genre, :id, :name, :cover
json.packs @genre.packs.order(created_at: :desc)
