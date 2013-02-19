require_relative '../../../spec_helper'
require_relative '../factories/user'

describe User do

  it "create user" do
    lambda{
      FactoryGirl.create(:user)
    }.should change(User, :count).by(1)
  end

end
