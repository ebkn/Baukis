class CreatePhones < ActiveRecord::Migration[5.1]
  def change
    create_table :phones do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :address, foreign_key: true
      t.string :number, null: false
      t.string :number_for_index, null: false
      t.string :last_four_digits, null: false
      t.boolean :primary, null: false, default: false
      t.timestamps null: false
    end

    add_index :phones, :number_for_index
    add_index :phones, :last_four_digits
  end
end
