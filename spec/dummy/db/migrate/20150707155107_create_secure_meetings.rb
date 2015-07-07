class CreateSecureMeetings < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :secure_meetings, id: :uuid do |t|
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end
end
