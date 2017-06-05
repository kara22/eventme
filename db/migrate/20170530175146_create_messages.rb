class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :match, foreign_key: true
      t.integer :sender_id, index: true, foreign_key: true
      t.integer :recipient_id, index: true, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
