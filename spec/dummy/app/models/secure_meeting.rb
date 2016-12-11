class SecureMeeting < ActiveRecord::Base
  validates :starts_at, :ends_at, overlap: true
end
