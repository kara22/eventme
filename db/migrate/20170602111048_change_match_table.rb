class ChangeMatchTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :matches, :user_1, :user_1_id
    rename_column :matches, :user_2, :user_2_id
  end
end
