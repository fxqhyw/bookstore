class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :first_name
      t.string :last_name
      t.string :number
      t.string :expiration_date
      t.string :cvv

      t.timestamps
    end
  end
end
