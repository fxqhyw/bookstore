class RemoveStringFromShippingAddress < ActiveRecord::Migration[5.2]
  def change
    remove_column :shipping_addresses, :string, :string
  end
end
