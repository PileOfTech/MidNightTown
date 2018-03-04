class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :image, null: false
      t.integer :watches, default: 0
      t.integer :likes, default: 0
      t.belongs_to :pack
      t.timestamps
    end
  end
end
