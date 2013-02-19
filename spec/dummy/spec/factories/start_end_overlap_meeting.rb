FactoryGirl.define do
  factory :start_end_overlap_meeting do |u|
    u.starts_at '2011-01-05'.to_date
    u.ends_at '2011-01-08'.to_date
  end
end
