describe OverlapValidator do


  context "validation message" do

    it "should have default message" do
      subject = OverlapValidator.new({:attributes => [:starts_at, :ends_at]})
      meeting = Meeting.new
      subject.stub(:find_crossed){true}
      subject.validate(meeting)
      meeting.errors[:starts_at].should eq ["overlaps with another record"]
    end

    it "should be possible to configure message" do
      subject = OverlapValidator.new({:attributes => [:starts_at, :ends_at]})
      meeting = Meeting.new
      subject.stub(:find_crossed){true}
      subject.stub(:options){ {:message_title => :optional_key, :message_content => "Message content"} }
      subject.validate(meeting)
      meeting.errors.messages.should eq :optional_key => ["Message content"]
    end

  end
end
