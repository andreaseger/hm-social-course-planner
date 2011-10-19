require 'spec_helper'

describe "schedules/show.html.haml" do
  before(:each) do
    @schedule = assign(:schedule, stub_model(Schedule,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
