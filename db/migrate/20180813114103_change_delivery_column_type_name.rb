class ChangeDeliveryColumnTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :deliveries, :type, :name
  end
end
