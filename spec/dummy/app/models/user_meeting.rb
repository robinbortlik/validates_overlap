class UserMeeting < ActiveRecord::Base
  validates :starts_at, :ends_at, :overlap => {:scope => "user_id"}
end
