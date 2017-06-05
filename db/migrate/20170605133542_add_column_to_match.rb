class AddColumnToMatch < ActiveRecord::Migration[5.0]
  def change
    add_reference :matches, :event, foreign_key: true
  end
end
