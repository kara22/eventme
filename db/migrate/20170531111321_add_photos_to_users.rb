class AddPhotosToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :picture1, :string
    add_column :users, :picture2, :string
    add_column :users, :picture3, :string
    add_column :users, :picture4, :string
    add_column :users, :picture5, :string
    add_column :users, :picture6, :string
  end
end
