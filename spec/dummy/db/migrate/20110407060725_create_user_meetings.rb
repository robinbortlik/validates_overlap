class CreateUserMeetings < ActiveRecord::Migration
  def self.up
    create_table :user_meetings do |t|
      t.integer :user_id
      t.date :starts_at
      t.date :ends_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_meetings
  end
end
