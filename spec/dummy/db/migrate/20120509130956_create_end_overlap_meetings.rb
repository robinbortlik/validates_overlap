class CreateEndOverlapMeetings < ActiveRecord::Migration[6.0]
  def self.up
    create_table :end_overlap_meetings do |t|
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end

  def self.down
    drop_table :end_overlap_meetings
  end
end
