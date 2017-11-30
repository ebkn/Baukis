class AlterAddresses1 < ActiveRecord::Migration[5.0]
  def change
    add_index :addresses, %i[type prefecture city]
    add_index :addresses, %i[type city]
    add_index :addresses, %i[prefecture city]
    add_index :addresses, :city
  end
end
