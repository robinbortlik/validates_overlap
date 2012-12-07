class CreateTimeSlot < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end

    create_table :positions do |t|
      t.belongs_to :user
      t.belongs_to :time_slot
      t.timestamps
    end
  end

  def self.down
    drop_table :time_slots
    drop_table :positions
  end
end
