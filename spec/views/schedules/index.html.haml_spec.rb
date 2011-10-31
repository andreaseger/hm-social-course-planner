require 'spec_helper'

describe "schedules/index.html.haml" do
  before(:each) do
    assign(:schedules, [
      stub_model(Schedule,
        :user_id => 1
      ),
      stub_model(Schedule,
        :user_id => 1
      )
    ])
  end

  it "renders a list of schedules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
