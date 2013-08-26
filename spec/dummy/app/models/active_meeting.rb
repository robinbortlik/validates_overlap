class ActiveMeeting < ActiveRecord::Base
  validates :starts_at, :ends_at, :overlap => {:query_options => {:active => true}}
  scope :active, where(:is_active => true)
end
