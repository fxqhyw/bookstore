class CreateAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :type, null: false
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :string
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
