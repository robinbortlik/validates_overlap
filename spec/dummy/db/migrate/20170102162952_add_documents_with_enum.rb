class AddDocumentsWithEnum < ActiveRecord::Migration
  def self.up
    create_table :documents_with_enum do |t|
      t.date :valid_from
      t.date :valid_until
      t.integer :kind
      t.timestamps
    end
  end

  def self.down
    drop_table :documents_with_enum
  end
end
