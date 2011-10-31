require 'spec_helper'

describe Group do
  context '#validation' do
    it "should have at least a name" do
      FactoryGirl.build(:group, name: nil).should_not be_valid
    end
    it "should ashure that name is unique" do
      FactoryGirl.create(:group, name: "foobarbaz" )
      FactoryGirl.build(:group, name: "foobarbaz" ).should_not be_valid
    end
  end
end
