class CreatePacks < ActiveRecord::Migration[5.1]
  def change
    create_table :packs do |t|
      t.string :name, null: false
      t.text :description
      t.string :cover
      t.belongs_to :genre
      t.timestamps
    end
  end
end