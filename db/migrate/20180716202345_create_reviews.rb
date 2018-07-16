class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :description
      t.integer :rating
      t.string :status
      t.belongs_to :book, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
