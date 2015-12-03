class Shift < ActiveRecord::Base
  validates :starts_at, :ends_at, :overlap => {:start_shift => -1.day, :end_shift => 1.day}
end
