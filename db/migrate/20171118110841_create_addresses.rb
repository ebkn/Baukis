class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :type, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address1, null: false
      t.string :address2, null: false
      t.string :company_name, null: false, default: ''
      t.string :division_name, null: false, default: ''
      t.timestamps null: false
    end

    add_index :addresses, %i[type customer_id], unique: true
    add_index :addresses, %i[type prefecture city]
    add_index :addresses, %i[type city]
    add_index :addresses, %i[prefecture city]
    add_index :addresses, :postal_code
    add_index :addresses, :city
  end
end
