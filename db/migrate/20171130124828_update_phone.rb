class UpdatePhone < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      UPDATE phones SET
        last_four_digits = SUBSTR(number_for_index, LENGTH(number_for_index) - 3)
          WHERE number_for_index IS NOT NULL AND LENGTH(number_for_index) >= 4
    SQL
  end

  def down
    execute <<-SQL
      UPDATE phones SET
        last_four_digits = NULL
    SQL
  end
end
