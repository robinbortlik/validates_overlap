require_relative '../../../spec_helper'
require_relative '../factories/meeting'

describe Meeting do

  context "Validation" do
    before(:all) do
      Meeting.delete_all
    end

    it "create meeting" do
      lambda {
        FactoryGirl.create(:meeting)
      }.should change(Meeting, :count).by(1)
    end

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

  context "Validation of endless objects" do
    before(:all) do
      Meeting.delete_all
      FactoryGirl.create(:meeting, :ends_at => nil)
    end

    it "with overlap object" do
      meeting = FactoryGirl.build(:meeting, :starts_at => "2011-01-05".to_date, :ends_at => "2011-01-08".to_date)
      meeting.should_not be_valid
      meeting = FactoryGirl.build(:meeting, :starts_at => "2012-01-05".to_date, :ends_at => "2012-01-08".to_date)
      meeting.should_not be_valid
      meeting = FactoryGirl.build(:meeting, :starts_at => "2010-01-05".to_date, :ends_at => "2010-01-08".to_date)
      meeting.should be_valid
    end

    it "with another endless obejct" do
      meeting = FactoryGirl.build(:meeting, :starts_at => "2010-01-05".to_date, :ends_at => nil)
      meeting.should_not be_valid
      meeting = FactoryGirl.build(:meeting, :starts_at => nil, :ends_at => "2010-01-05".to_date)
      meeting.should be_valid
      meeting = FactoryGirl.build(:meeting, :starts_at => nil, :ends_at => nil)
      meeting.should_not be_valid
    end
  end

end
