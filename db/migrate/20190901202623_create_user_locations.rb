class CreateUserLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_locations do |t|
      t.integer :user_id, null: false
      t.integer :location_id, null: false
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
