require 'spec_helper'

describe "schedules/edit.html.haml" do
  before(:each) do
    @schedule = assign(:schedule, stub_model(Schedule,
      :name => "MyString"
    ))
  end

  it "renders the edit schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => schedules_path(@schedule), :method => "post" do
      assert_select "input#schedule_name", :name => "schedule[name]"
    end
  end
end
