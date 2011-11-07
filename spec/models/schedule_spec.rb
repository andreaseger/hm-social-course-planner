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
  context '#bookings_without_conflict' do
    before do
      @booking = FactoryGirl.create(:booking_with_teacher)
      @schedule = FactoryGirl.create(:schedule_with_bookings)
      @schedule.should have(1).booking
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
  context '#fill_with_related!' do
    before do
      FactoryGirl.create(:booking_with_teacher)
      @schedule = FactoryGirl.create(:schedule_with_bookings)
      @booking = FactoryGirl.create(:booking_with_teacher, course: @schedule.bookings.first.course)
      @schedule.should have(1).bookings
    end
    it 'should add all related bookings of any of the current bookings to the schedule' do
      @schedule.fill_with_related!
      @schedule.should have(2).bookings
    end
    it 'should only add bookings which are related to the already used ones' do
      @schedule.fill_with_related!
      @schedule.bookings.should include @booking
    end
    it 'should save the schedule' do
      @schedule.fill_with_related!
      @schedule.changed?.should be_false
    end
    it 'should not add a booking twice' do
      @schedule.bookings << @booking
      @schedule.should have(2).bookings
      @schedule.fill_with_related!
      @schedule.should have(2).bookings
    end
  end
end
