require_relative '../../../spec_helper'
require_relative '../factories/user'

describe User do
  it 'create user' do
    expect do
      FactoryGirl.create(:user)
    end.to change(User, :count).by(1)
  end
end
