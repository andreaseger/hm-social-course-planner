require 'spec_helper'

describe Room do
  context '#validation' do
    %w(name label building floor).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:room, a => nil).should_not be_valid
      end
    end
    it "should ashure that name is unique" do
      FactoryGirl.create(:room, name: "foobarbaz" )
      FactoryGirl.build(:room, name: "foobarbaz" ).should_not be_valid
    end
  end
end
