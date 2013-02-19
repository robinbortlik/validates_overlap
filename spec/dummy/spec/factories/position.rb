FactoryGirl.define do
  factory :position do |u|
    u.association(:user, :factory => :user)
    u.association(:time_slot, :factory => :time_slot)
  end
end
