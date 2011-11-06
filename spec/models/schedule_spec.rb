require 'spec_helper'

describe Schedule do
  context '#validations' do
    it 'should exists a valid factory' do
      FactoryGirl.build(:schedule_with_bookings).should be_valid
    end
    it 'should at least have a user' do
      FactoryGirl.build(:schedule_with_bookings, user: nil).should_not be_valid
    end
  end
end
