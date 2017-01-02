require "#{File.dirname(__FILE__)}/../../../spec_helper"

describe ActiveMeeting do
  context 'scoping' do
    it 'should apply scope' do
      expect(ActiveMeeting).to receive(:active).and_call_original
      active_meeting = ActiveMeeting.new
      expect(active_meeting).to be_valid
    end
  end
end
