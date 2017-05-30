class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :user_1, index: true, foreign_key: true
      t.integer :user_2, index: true, foreign_key: true

      t.timestamps
    end
  end
end
