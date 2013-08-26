require_relative '../../../spec_helper'
require_relative '../factories/active_meeting'

describe ActiveMeeting do

  before(:all) do
    ActiveMeeting.delete_all
  end

  context "scoping" do
    it "should apply scope" do
      ActiveMeeting.should_receive(:active).with(true).and_call_original
      active_meeting = ActiveMeeting.new
      active_meeting.valid?
    end
  end

end
