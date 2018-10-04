class DropBillingAddresses < ActiveRecord::Migration[5.2]
  def change
    drop_table :billing_addresses
  end
end
