class CreateStartOverlapMeetings < ActiveRecord::Migration
  def self.up
    create_table :start_overlap_meetings do |t|
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end

  def self.down
    drop_table :start_overlap_meetings
  end
end
