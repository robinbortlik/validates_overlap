class Meeting < ActiveRecord::Base
  validates :starts_at, :ends_at, overlap: { load_overlapped: true }
end
