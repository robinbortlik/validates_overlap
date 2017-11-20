class Position < ActiveRecord::Base
  belongs_to :time_slot
  belongs_to :user
  if ActiveRecord::VERSION::MAJOR >= 5
    @@query_options = { includes: :time_slot, references: :time_slot }
  else
    @@query_options = { includes: :time_slot }
  end

  validates :"time_slots.starts_at", :"time_slots.ends_at",
            overlap: {
              query_options: @@query_options,
              scope: { 'positions.user_id' => proc { |position| position.user_id } }
            }



end
