class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :email_for_index, null: false
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.string :gender
      t.date :birthday
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_mday
      t.string :hashed_password
      t.timestamps null: false
    end

    add_index :customers, :email_for_index, unique: true
    add_index :customers, %i[family_name_kana given_name_kana]
    add_index :customers, %i[gender family_name_kana given_name_kana],
                          name: 'index_customers_on_gender_and_kana'
    add_index :customers, %i[birth_year birth_month birth_mday]
    add_index :customers, %i[birth_month birth_mday]
    add_index :customers, :given_name_kana
    add_index :customers, %i[birth_year family_name_kana given_name_kana], name: 'index_customers_on_birth_year_and_kana'
    add_index :customers, %i[birth_year given_name_kana]
    add_index :customers, %i[birth_month family_name_kana given_name_kana], name: 'index_customers_on_birth_month_and_kana'
    add_index :customers, %i[birth_month given_name_kana]
    add_index :customers, %i[birth_mday family_name_kana given_name_kana], name: 'index_customers_on_birth_mday_nad_kana'
    add_index :customers, %i[birth_mday given_name_kana]
  end
end
