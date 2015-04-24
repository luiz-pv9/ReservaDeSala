class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :week_id
      t.integer :user_id
      t.integer :time_start
      t.integer :time_end
      t.integer :day_index
      t.timestamps null: false
    end
  end
end
