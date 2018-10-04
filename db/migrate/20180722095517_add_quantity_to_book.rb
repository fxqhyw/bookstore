class AddQuantityToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :quantity, :integer
  end
end
