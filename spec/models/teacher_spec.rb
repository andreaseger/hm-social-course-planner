require 'spec_helper'

describe Teacher do
  context '#validation' do
    %w(name label).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:teacher, a => nil).should_not be_valid
      end
    end
    it "should ashure that name is unique" do
      FactoryGirl.create(:teacher, name: "foobarbaz" )
      FactoryGirl.build(:teacher, name: "foobarbaz" ).should_not be_valid
    end
  end
end
