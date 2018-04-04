class CreateStaffEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :staff_events do |t|
      t.references :staff_member, foreign_key: true
      t.string :type, null: false
      t.timestamps null: false
    end

    add_index :staff_events, :created_at
    add_index :staff_events, [:staff_member_id, :created_at]
  end
end
