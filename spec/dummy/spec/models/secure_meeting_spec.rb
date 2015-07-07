require_relative '../../spec/factories/secure_meeting'

describe SecureMeeting do
  context "A model with a UUID as a primary key" do
    before(:all) do
      SecureMeeting.delete_all
    end

    it "updates the relevant record" do
      securemeeting = FactoryGirl.create(:secure_meeting)
      securemeeting.update(starts_at: '2012-01-05'.to_date, ends_at: '2012-02-05'.to_date)
      securemeeting.should be_valid
      securemeeting.errors[:starts_at].should be_empty
      securemeeting.errors[:ends_at].should be_empty
    end
  end
end
