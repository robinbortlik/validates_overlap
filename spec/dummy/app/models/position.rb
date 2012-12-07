class Position < ActiveRecord::Base
  belongs_to :time_slot
  belongs_to :user
  validates "time_slots.starts_at", "time_slots.ends_at",
    :overlap => {
      :query_options => {:includes => :time_slot},
      :scope => { "positions.user_id" => proc{|position| position.user_id} }
    }
end
