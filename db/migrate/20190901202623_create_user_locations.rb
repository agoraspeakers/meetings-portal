class CreateUserLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_locations do |t|
      t.integer :user_id
      t.integer :location_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
