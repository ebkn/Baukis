class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.references :customer, foreign_key: true
      t.references :address, foreign_key: true
      t.string :number, null: false
      t.string :number_for_index, null: false
      t.boolean :primary, null: false, default: false
      t.timestamps
    end

    add_index :phones, :number_for_index
  end
end
