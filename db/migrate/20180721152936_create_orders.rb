class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.decimal :total_price
      t.string :status
      t.belongs_to :shipping_address, foreign_key: true
      t.belongs_to :billing_address, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :delivery, foreign_key: true
      t.belongs_to :credit_card, foreign_key: true

      t.timestamps
    end
  end
end
