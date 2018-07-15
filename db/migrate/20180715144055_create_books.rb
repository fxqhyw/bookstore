class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :published_at
      t.decimal :price, precision: 6, scale: 2
      t.string :materials
      t.decimal :height, precision: 4, scale: 1
      t.decimal :weight, precision: 4, scale: 1
      t.decimal :depth, precision: 4, scale: 1

      t.timestamps
    end
  end
end
