require 'spec_helper'

describe Course do
  context '#validation' do
    %w(name label).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:course, a => nil).should_not be_valid
      end
    end
    it "should ashure that name is unique" do
      FactoryGirl.create(:course, name: "foobarbaz" )
      FactoryGirl.build(:course, name: "foobarbaz" ).should_not be_valid
    end
  end
end
