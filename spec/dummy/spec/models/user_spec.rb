require 'spec_helper'

describe User do

  it "create user" do
    lambda{
      Factory(:user)
    }.should change(User, :count).by(1)
  end

end