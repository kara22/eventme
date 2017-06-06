class ChangeDateFormatInEvents < ActiveRecord::Migration[5.0]
  def up
    change_column :events, :start_time, :datetime
    change_column :events, :end_time, :datetime
  end

  def down
    change_column :events, :start_time, :date
    change_column :events, :end_time, :date
  end
end


