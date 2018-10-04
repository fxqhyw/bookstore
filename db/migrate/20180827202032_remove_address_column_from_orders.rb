class RemoveAddressColumnFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders, :address, foreign_key: true
  end
end
