require_relative '../../../spec_helper'
require_relative '../factories/meeting'

describe Meeting do

  before(:all) do
    Meeting.delete_all
  end

  it "create meeting" do
    lambda {
      FactoryGirl.create(:meeting)
    }.should change(Meeting, :count).by(1)
  end

  context "Validation" do

    OVERLAP_TIME_RANGES.each do |description, time_range|
      it "is not valid if exists meeting which #{description}" do
        meeting = FactoryGirl.build(:meeting, :starts_at => time_range.first, :ends_at => time_range.last)
        meeting.should_not be_valid
        meeting.errors[:starts_at].should_not be_empty
        meeting.errors[:ends_at].should be_empty
      end
    end

    it " validate object which has not got overlap" do
        meeting = FactoryGirl.build(:meeting, :starts_at => "2011-01-09".to_date, :ends_at => "2011-01-11".to_date)
        meeting.should be_valid
        meeting.errors[:starts_at].should be_empty
        meeting.errors[:ends_at].should be_empty

        meeting = FactoryGirl.build(:meeting, :starts_at => "2011-01-01".to_date, :ends_at => "2011-01-02".to_date)
        meeting.should be_valid
        meeting.errors[:starts_at].should be_empty
        meeting.errors[:ends_at].should be_empty
    end

  end

end
