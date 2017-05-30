class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :fb_event_id
      t.string :name
      t.integer :attending_count
      t.string :start_time
      t.string :end_time
      t.string :cover
      t.string :place_name
      t.float :place_latitude
      t.float :place_longitude

      t.timestamps
    end
  end
end
