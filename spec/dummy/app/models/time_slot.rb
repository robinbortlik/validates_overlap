class TimeSlot < ActiveRecord::Base
  has_many :positions

  if ActiveRecord::VERSION::MAJOR >= 5
    @@query_options = { includes: :positions, references: :positions }
  else
    @@query_options = { includes: :positions }
  end

  validates :"time_slots.starts_at", :"time_slots.ends_at",
            overlap: {
              query_options: @@query_options,
              scope: { 'positions.user_id' => proc { |time_slot| time_slot.positions.map(&:user_id) } }
            }
end
