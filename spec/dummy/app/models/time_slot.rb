class TimeSlot < ActiveRecord::Base
  has_many :positions
  validates "time_slots.starts_at", "time_slots.ends_at",
    :overlap => {
      :query_options => {:includes => :positions},
      :scope => {"positions.user_id" => proc{|time_slot| time_slot.positions.map(&:user_id)} }
    }
end
