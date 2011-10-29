require 'spec_helper'

describe Day do
  context '#validation' do
    %w(name label).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:day, a => nil).should_not be_valid
      end
    end
    it "should ashure that name is unique" do
      FactoryGirl.create(:day, name: "foobarbaz" )
      FactoryGirl.build(:day, name: "foobarbaz" ).should_not be_valid
    end
  end
end
