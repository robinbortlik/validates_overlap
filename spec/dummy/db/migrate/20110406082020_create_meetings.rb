class CreateMeetings < ActiveRecord::Migration[6.0]
  def self.up
    create_table :meetings do |t|
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end
