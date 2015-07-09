class CreateSecureMeetings < ActiveRecord::Migration
  def self.up
    create_table :secure_meetings, id: false do |t|
      t.primary_key :id
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end

  def self.down
    drop_table :secure_meetings
  end
end
