module SessionMacros
  def do_login
    visit login_path
    click_link "Developer"
    fill_in "Name", :with => @user.username
    fill_in "Email", :with => @user.email
    click_button "Sign In"
  end
  def do_logout
    visit logout_path
  end
end
