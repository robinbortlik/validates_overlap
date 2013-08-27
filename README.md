[![Build Status](https://secure.travis-ci.org/robinbortlik/validates_overlap.png?branch=master)](https://secure.travis-ci.org/robinbortlik/validates_overlap)

# ValidatesOverlap

This project rocks and uses MIT-LICENSE.

#### This gem is compatible with Rails 3 and 4.

#### When this gem should be helpful for you?
If you are developing Rails 3 app, let say some meeting planner and you can't save records which have time overlap.

#### Using

Add to your gemfile

```ruby
gem 'validates_overlap'
```

In your model

#### without scope

```ruby
validates :starts_at, :ends_at, :overlap => true
```

#### with scope

```ruby
validates :starts_at, :ends_at, :overlap => {:scope => "user_id"}
```

#### exclude edges

```ruby
validates :starts_at, :ends_at, :overlap => {:exclude_edges => "starts_at"}
validates :starts_at, :ends_at, :overlap => {:exclude_edges => ["starts_at", "ends_at"]}
```

#### define custom validation key and message

```ruby
validates :starts_at, :ends_at, :overlap => {:message_title => "Some validation title", :message_content => "Some validation message"}
```

#### with complicated relations

Example describes valildatation of user, positions and time slots.
User can't be assigned 2 times on position which is under time slot with time overlap.

```ruby
class Position < ActiveRecord::Base
  belongs_to :time_slot
  belongs_to :user
  validates "time_slots.starts_at", "time_slots.ends_at",
    :overlap => {
      :query_options => {:includes => :time_slot},
      :scope => { "positions.user_id" => proc{|position| position.user_id} }
    }
end
```

#### apply named scopes

```ruby
class ActiveMeeting < ActiveRecord::Base
  validates :starts_at, :ends_at, :overlap => {:query_options => {:active => true}}
  scope :active, where(:is_active => true)
end
```
