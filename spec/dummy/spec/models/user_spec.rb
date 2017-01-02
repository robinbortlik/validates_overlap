require "#{File.dirname(__FILE__)}/../../../spec_helper"

describe User do
  it 'create user' do
    expect do
      FactoryGirl.create(:user)
    end.to change(User, :count).by(1)
  end
end
