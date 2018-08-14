class RemoveLastNameFromCreditCard < ActiveRecord::Migration[5.2]
  def change
    remove_column :credit_cards, :last_name
    rename_column :credit_cards, :first_name, :name
  end
end
