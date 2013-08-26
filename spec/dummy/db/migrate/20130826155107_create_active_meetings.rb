class CreateActiveMeetings < ActiveRecord::Migration
  def self.up
    create_table :active_meetings do |t|
      t.date :starts_at
      t.date :ends_at
      t.boolean :is_active
      t.timestamps
    end
  end

  def self.down
    drop_table :active_meetings
  end
end
