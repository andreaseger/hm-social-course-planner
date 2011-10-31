require 'spec_helper'

describe "schedules/edit.html.haml" do
  before(:each) do
    @schedule = assign(:schedule, stub_model(Schedule,
      :user_id => 1
    ))
  end

  it "renders the edit schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => schedules_path(@schedule), :method => "post" do
      assert_select "input#schedule_user_id", :name => "schedule[user_id]"
    end
  end
end
