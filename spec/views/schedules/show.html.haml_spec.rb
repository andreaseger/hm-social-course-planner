require 'spec_helper'

describe "schedules/show.html.haml" do
  before(:each) do
    @schedule = assign(:schedule, stub_model(Schedule,
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
