class EndOverlapMeeting < ActiveRecord::Base
  validates :starts_at, :ends_at, :overlap => {:exclude_edges => :ends_at}
end