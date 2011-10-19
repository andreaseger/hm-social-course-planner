require 'spec_helper'

describe "schedules/new.html.haml" do
  before(:each) do
    assign(:schedule, stub_model(Schedule,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => schedules_path, :method => "post" do
      assert_select "input#schedule_name", :name => "schedule[name]"
    end
  end
end
