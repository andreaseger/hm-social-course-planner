require 'spec_helper'

describe Timeslot do
  context '#validation' do
    %w(start_label start_time end_label end_time day).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:timeslot, a => nil).should_not be_valid
      end
    end
    %w(start_label end_label).each do |a|
      it "should ashure that #{a} is unique" do
        FactoryGirl.create(:timeslot, a => "foobarbaz" )
        FactoryGirl.build(:timeslot, a => "foobarbaz" ).should_not be_valid
      end
    end
    %w(start_time end_time).each do |a|
      it "should ashure that #{a} is unique" do
        FactoryGirl.create(:timeslot, a => 1232 )
        FactoryGirl.build(:timeslot, a => 1232 ).should_not be_valid
      end
    end
  end
end
