require_relative '../../spec/factories/secure_meeting'

describe SecureMeeting  do
  context "A model with a UUID as a primary key" do
    before(:all) do
    SecureMeeting.delete_all
    end

    it "updates the relevant record" do
      meeting_uuid = FactoryGirl.create(:secure_meeting)
      meeting_uuid.update(starts_at: '2012-01-05'.to_date, ends_at: '2012-02-05'.to_date)

      meeting_uuid.should be_valid # or .should_not be_valid
      meeting_uuid.errors[:starts_at].should be_empty # or .should_not be_empty
      meeting_uuid.errors[:ends_at].should be_empty
    end
  end
end
