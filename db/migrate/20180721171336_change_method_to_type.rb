class ChangeMethodToType < ActiveRecord::Migration[5.2]
  def change
    rename_column :deliveries, :method, :type
  end
end
