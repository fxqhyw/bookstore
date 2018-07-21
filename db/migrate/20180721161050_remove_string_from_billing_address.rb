class RemoveStringFromBillingAddress < ActiveRecord::Migration[5.2]
  def change
    remove_column :billing_addresses, :string, :string
  end
end
