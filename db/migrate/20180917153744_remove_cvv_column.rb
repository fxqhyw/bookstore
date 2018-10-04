class RemoveCvvColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :credit_cards, :cvv
  end
end
