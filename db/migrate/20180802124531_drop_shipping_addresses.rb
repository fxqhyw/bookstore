class DropShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    drop_table :shipping_addresses
  end
end
