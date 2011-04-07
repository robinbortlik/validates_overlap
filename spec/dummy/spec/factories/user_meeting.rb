Factory.define :johns_meeting, :class => UserMeeting do |u|
  u.starts_at '2011-01-05'.to_date
  u.ends_at '2011-01-08'.to_date
  u.user_id 1
end

Factory.define :peters_meeting, :class => UserMeeting do |u|
  u.starts_at '2011-01-05'.to_date
  u.ends_at '2011-01-08'.to_date
  u.user_id 2
end