require_relative '../../../spec_helper'
require_relative '../factories/secure_meeting'

describe SecureMeeting do
  context "A model with a UUID as a primary key" do
    before(:all) do
      if SecureMeeting.count >= 1 then
        SecureMeeting.delete_all
      end
    end

    it "updates the relevant record" do
      securemeeting = FactoryGirl.create(:secure_meeting)
      securemeeting.starts_at = '2012-01-05'.to_date
      securemeeting.ends_at = '2012-02-05'.to_date
      securemeeting.should be_valid
      securemeeting.errors[:starts_at].should be_empty
      securemeeting.errors[:ends_at].should be_empty
    end
  end
end
