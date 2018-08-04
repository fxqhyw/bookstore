class UpdateForeignKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :carts, :users
    add_foreign_key :carts, :users, on_delete: :cascade
  end
end
