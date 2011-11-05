require 'spec_helper'

describe Booking do
  context '#validation' do
    %w(course room timeslot group).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:booking, a => nil).should_not be_valid
      end
    end
    it 'should be invalid if it has no teacher' do
      FactoryGirl.build(:booking).should_not be_valid
    end
    it 'should be valid with teachers' do
      FactoryGirl.build(:booking, teachers: FactoryGirl.create_list(:teacher,2) ).should be_valid
    end
  end
end
