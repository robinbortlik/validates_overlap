[![Build Status](https://secure.travis-ci.org/robinbortlik/validates_overlap.png?branch=master)](https://secure.travis-ci.org/robinbortlik/validates_overlap)

# ValidatesOverlap

This project rocks and uses MIT-LICENSE.

#### This gem is compatible with Rails 3, 4, 5.

#### When this gem should be helpful for you?
Ideal solution for booking applications where you want to make sure, that one place can be booked only once in specific time period.

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

#### shift edges

```ruby
validates :starts_at, :ends_at, :overlap => {:start_shift => -1.day, :end_shift => 1.day}
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
  validates :starts_at, :ends_at, :overlap => {:query_options => {:active => nil}}
  scope :active, where(:is_active => true)
end
```

#### Overlapped records
If you need to know what records are in conflict, the OverlapValidator set instance variable `@overlapped_records` to the validated object.
So you  can simply read them by definning your reader like this

```ruby
def overlapped_records
  @overlapped_records
end
```

## Rails 4.1 update

If you just upgraded your application to rails 4.1 you can discover some issue with custom scopes. In older versions we suggest to use definition like

```ruby
  {:overlap => {:query_options => {:active => true}}}
```

but this code is not longer working. Currently please change your code to

```ruby
  {:overlap => {:query_options => {:active => nil}}}
```
Thanks @supertinou for discovering and fix of this bug.
