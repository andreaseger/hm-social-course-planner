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
  context '#tentative' do
    it 'should be possible to choose bookings to be tentative'
    it 'should not use tentative bookings in any conflict matching'
  end
  context '#bookings_without_conflict' do
    before do
      @booking = FactoryGirl.create(:booking_with_teacher)
      @schedule = FactoryGirl.create(:schedule_with_bookings)
    end

    it 'should deliver all bookings without conflict with any of the bookings in the schedule' do
      @schedule.bookings_without_conflict.should have(1).thing
    end
    it 'should be the other existing booking' do
      @schedule.bookings_without_conflict.should include @booking
    end
    it 'should not bookings which have a related which is in conflict'
    it 'should be able to filter by group'
  end
  context '#fill_with_related_bookings' do
    it 'should check if for each booking all related ones are included'
    it 'should add all related bookings of any of the current bookings to the schedule'
  end
end
