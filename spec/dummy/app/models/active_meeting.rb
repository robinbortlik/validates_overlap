class ActiveMeeting < ActiveRecord::Base
  validates :starts_at, :ends_at, overlap: { query_options: { active: nil } }
  scope :active, -> { where(is_active: true) }
end
