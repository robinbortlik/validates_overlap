require_relative '../../../spec_helper'
require_relative '../factories/user_meeting'

describe UserMeeting do

  before(:all) do
    UserMeeting.delete_all
  end

  it "create johns meeting" do
    lambda {
      FactoryGirl.create(:johns_meeting)
    }.should change(UserMeeting, :count).by(1)
  end

  context "Validation with scope" do

    OVERLAP_TIME_RANGES.each do |description, time_range|
      it "is not valid if exists johns meeting which #{description}" do
        meeting = FactoryGirl.build(:johns_meeting, :starts_at => time_range.first, :ends_at => time_range.last)
        meeting.should_not be_valid
        meeting.errors[:starts_at].should_not be_empty
        meeting.errors[:ends_at].should be_empty
      end
    end

    OVERLAP_TIME_RANGES.each do |description, time_range|
      it "is valid if exists johns meeting which #{description}" do
        meeting = FactoryGirl.build(:peters_meeting, :starts_at => time_range.first, :ends_at => time_range.last)
        meeting.should be_valid
        meeting.errors[:starts_at].should be_empty
        meeting.errors[:ends_at].should be_empty
      end
    end

  end

end
