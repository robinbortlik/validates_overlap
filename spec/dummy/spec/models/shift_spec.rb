require_relative '../../../spec_helper'
require_relative '../factories/shift'

describe Meeting do

  context "Validation" do
    before(:all) do
      Shift.delete_all
    end

    it "create meeting" do
      lambda {
        FactoryGirl.create(:shift)
      }.should change(Shift, :count).by(1)
    end

    it "is not valid if exists shift within wider range" do
      shift = FactoryGirl.build(:shift, :starts_at => "2011-01-09".to_date, :ends_at => "2011-01-11".to_date)
      shift.should_not be_valid
      shift.errors[:starts_at].should_not be_empty
      shift.errors[:ends_at].should be_empty

      shift = FactoryGirl.build(:shift, :starts_at => "2011-01-01".to_date, :ends_at => "2011-01-04".to_date)
      shift.should_not be_valid
      shift.errors[:starts_at].should_not be_empty
      shift.errors[:ends_at].should be_empty
    end

    it " validate object which has not got overlap" do
      shift = FactoryGirl.build(:shift, :starts_at => "2011-01-10".to_date, :ends_at => "2011-01-11".to_date)
      shift.should be_valid
      shift.errors[:starts_at].should be_empty
      shift.errors[:ends_at].should be_empty

      shift = FactoryGirl.build(:shift, :starts_at => "2011-01-01".to_date, :ends_at => "2011-01-02".to_date)
      shift.should be_valid
      shift.errors[:starts_at].should be_empty
      shift.errors[:ends_at].should be_empty
    end

  end

end
