require 'spec_helper'

describe "profiles/new.html.haml" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :firstname => "MyString",
      :lastname => "MyString",
      :website => "MyString",
      :twitter => "MyString",
      :bio => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => profiles_path, :method => "post" do
      assert_select "input#profile_firstname", :name => "profile[firstname]"
      assert_select "input#profile_lastname", :name => "profile[lastname]"
      assert_select "input#profile_website", :name => "profile[website]"
      assert_select "input#profile_twitter", :name => "profile[twitter]"
      assert_select "textarea#profile_bio", :name => "profile[bio]"
      assert_select "input#profile_user", :name => "profile[user]"
    end
  end
end
