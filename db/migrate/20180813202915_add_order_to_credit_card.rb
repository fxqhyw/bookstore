class AddOrderToCreditCard < ActiveRecord::Migration[5.2]
  def change
    add_reference :credit_cards, :order, foreign_key: true
  end
end
