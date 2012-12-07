require_relative '../../../spec_helper'
require_relative '../factories/position'
require_relative '../factories/time_slot'
require_relative '../factories/user'

describe Position do

  before(:all) do
    Position.delete_all
    TimeSlot.delete_all
    User.delete_all
  end

  it "create position" do
    lambda {
      Factory(:position)
    }.should change(Position, :count).by(1)
  end

  context "Validation with scope and association" do

    it "is not valid if exists time slot which have position with same person" do
      time_slot1 = Factory.create(:time_slot, :starts_at => "2012-10-11".to_date, :ends_at => "2012-10-13".to_date)
      time_slot2 = Factory.create(:time_slot, :starts_at => "2012-10-12".to_date, :ends_at => "2012-10-13".to_date)
      user = Factory.create(:user)
      position1 = Factory.create(:position, :time_slot => time_slot1, :user => user)
      position2 = Factory.build(:position, :time_slot => time_slot2, :user => user)
      position2.should_not be_valid
      position2.errors[:base].should_not be_empty
    end

    it "is be valid if exists time slot which have position with same person" do
      time_slot1 = Factory.create(:time_slot, :starts_at => "2012-10-11".to_date, :ends_at => "2012-10-13".to_date)
      time_slot2 = Factory.create(:time_slot, :starts_at => "2012-10-14".to_date, :ends_at => "2012-10-15".to_date)
      user = Factory.create(:user)
      position1 = Factory.create(:position, :time_slot => time_slot1, :user => user)
      position2 = Factory.build(:position, :time_slot => time_slot2, :user => user)
      position2.should be_valid
      position2.errors[:base].should be_empty
    end

  end

end
