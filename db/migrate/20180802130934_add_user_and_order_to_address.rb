class AddUserAndOrderToAddress < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :user, foreign_key: true
    add_reference :addresses, :order, foreign_key: true
  end
end
