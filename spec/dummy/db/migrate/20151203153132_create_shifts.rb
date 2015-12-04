class CreateShifts < ActiveRecord::Migration
  def self.up
    create_table :shifts do |t|
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end

  def self.down
    drop_table :shifts
  end
end
