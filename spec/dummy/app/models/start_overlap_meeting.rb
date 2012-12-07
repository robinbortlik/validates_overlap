class StartOverlapMeeting < ActiveRecord::Base
  validates :starts_at, :ends_at, :overlap => {:exclude_edges => :starts_at}
end
