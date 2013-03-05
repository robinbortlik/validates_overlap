require_relative '../../../spec_helper'
require_relative '../factories/position'
require_relative '../factories/time_slot'
require_relative '../factories/user'

describe TimeSlot do

  before(:all) do
    Position.delete_all
    TimeSlot.delete_all
    User.delete_all
  end

  it "create time_slot" do
    lambda {
      FactoryGirl.create(:time_slot)
    }.should change(TimeSlot, :count).by(1)
  end

  context "Validation with scope and association" do

    it "is not valid if exists time slot which have position with same person" do
      time_slot1 = FactoryGirl.create(:time_slot, :starts_at => "2012-10-11".to_date, :ends_at => "2012-10-13".to_date)
      time_slot2 = FactoryGirl.create(:time_slot, :starts_at => "2012-10-15".to_date, :ends_at => "2012-10-16".to_date)
      user = FactoryGirl.create(:user)
      user_2 = FactoryGirl.create(:user)
      position1 = FactoryGirl.create(:position, :time_slot => time_slot1, :user => user)
      position2 = FactoryGirl.create(:position, :time_slot => time_slot2, :user => user)
      position3 = FactoryGirl.create(:position, :time_slot => time_slot2, :user => user_2)
      time_slot2.reload
      time_slot2.starts_at = "2012-10-12".to_date
      time_slot2.should_not be_valid

      time_slot2.errors[:base].should_not be_empty
    end

    it "is valid if exists time slot which have position with same person" do
      time_slot1 = FactoryGirl.create(:time_slot, :starts_at => "2012-10-11".to_date, :ends_at => "2012-10-13".to_date)
      time_slot2 = FactoryGirl.create(:time_slot, :starts_at => "2012-10-14".to_date, :ends_at => "2012-10-16".to_date)
      user = FactoryGirl.create(:user)
      position1 = FactoryGirl.create(:position, :time_slot => time_slot1, :user => user)
      position2 = FactoryGirl.build(:position, :time_slot => time_slot2, :user => user)

      time_slot2.starts_at = "2012-10-15".to_date
      time_slot2.should be_valid
      time_slot2.errors[:base].should be_empty
    end

  end

end
