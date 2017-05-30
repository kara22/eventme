class CreateDecisions < ActiveRecord::Migration[5.0]
  def change
    create_table :decisions do |t|
      t.references :event, foreign_key: true
      t.integer :decision_maker_id, index: true, foreign_key: true
      t.integer :decision_receiver_id, index: true, foreign_key: true
      t.boolean :like
      t.boolean :pending

      t.timestamps
    end
  end
end
