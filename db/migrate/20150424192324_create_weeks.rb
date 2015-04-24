class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.datetime :beginning
      t.datetime :end
      t.timestamps null: false
    end
  end
end
