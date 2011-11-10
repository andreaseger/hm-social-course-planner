require 'spec_helper'

describe Timeslot do
  context '#validation' do
    %w(start_label start_time end_label end_time day).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:timeslot, a => nil).should_not be_valid
      end
    end
  end
end
