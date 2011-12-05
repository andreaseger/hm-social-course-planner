require 'spec_helper'

describe "SessionHandling" do
  before do
    @user = FactoryGirl.create(:user_with_auth)
  end
  it "should be possible to login with an existing user" do
    do_login
    current_path.should eq(user_profile_path)
    page.should have_content("Logout")
  end
  it "should be possible to logout" do
    do_login
    click_link "Logout"
    current_path.should eq(login_path)
  end
end
