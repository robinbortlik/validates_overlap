FactoryGirl.define do
  factory :active_meeting do |u|
    u.starts_at '2011-01-05'.to_date
    u.ends_at '2011-01-08'.to_date
    u.is_active true
  end
end
