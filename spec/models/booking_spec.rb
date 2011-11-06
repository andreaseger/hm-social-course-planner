require 'spec_helper'

describe Booking do
  context '#validation' do
    it 'should exists a valid factory' do
      FactoryGirl.build(:booking_with_teacher).should be_valid
    end
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

  context '#find_conflicted' do
    before do
      t = FactoryGirl.create(:timeslot)
      b = FactoryGirl.create_list(:booking_with_teacher,5, timeslot: t)
      @booking = b.first
      FactoryGirl.create_list(:booking_with_teacher,2)
    end

    it 'should deliver bookings with the same timeslot' do
      Booking.find_conflicted(@booking).should have(5).things
    end
    it 'should also work directly on an instance' do
      @booking.find_conflicted.should have(5).things
    end
    it 'should have the given instance included' do
      Booking.find_conflicted(@booking).should include(@booking)
    end

    it 'should not deliver the given instance if parameter is set to false' do
      Booking.find_conflicted(@booking, false).should have(4).things
    end
    it 'should do the same from an instance' do
      @booking.find_conflicted(false).should have(4).things
    end
    it 'should only deliver the other bookings' do
      Booking.find_conflicted(@booking, false).should_not include(@booking)
    end

    it 'should also find conflicted booking with an booking_id' do
      Booking.find_conflicted(@booking.id).should have(5).things
    end
  end

  context '#find_related' do
    before do
      c = FactoryGirl.create(:course)
      b = FactoryGirl.create_list(:booking_with_teacher,5, course: c)
      @booking = b.first
      FactoryGirl.create_list(:booking_with_teacher,2)
    end
    it 'should deliver bookings with the same course' do
      Booking.find_related(@booking).should have(5).things
    end
    it 'should also work directly on an instance' do
      @booking.find_related.should have(5).things
    end
    it 'should have the given instance included' do
      Booking.find_related(@booking).should include(@booking)
    end

    it 'should not deliver the given instance if parameter is set to false' do
      Booking.find_related(@booking, false).should have(4).things
    end
    it 'should do the same from an instance' do
      @booking.find_related(false).should have(4).things
    end
    it 'should only deliver the other bookings' do
      Booking.find_related(@booking, false).should_not include(@booking)
    end
    it 'should also find related booking with an booking_id' do
      Booking.find_related(@booking.id).should have(5).things
    end
  end

  context '#find_related_with_conflict' do
    before do
      t = FactoryGirl.create(:timeslot)
      b = FactoryGirl.create_list(:booking_with_teacher, 3, timeslot: t)
      b.each do |e|
        c = e.course
        FactoryGirl.create_list(:booking_with_teacher, 3, course: c)
      end
      @booking = b.first
      FactoryGirl.create_list(:booking_with_teacher,2)
    end
    it 'should find booking which are in conflict with itself or any of the related bookings' do
      Booking.find_related_with_conflict(@booking).should have(6).things
    end
    it 'should also work directly on an instance' do
      @booking.find_related_with_conflict.should have(6).things
    end
  end
  context '#find_conflict_free' do
    before do
      @used = FactoryGirl.create_list(:booking_with_teacher, 3)
      @free = FactoryGirl.create_list(:booking_with_teacher, 3)
    end
    it 'should deliver bookings which are not in conflict with any of the given ones' do
      Booking.find_conflict_free(@used).should == @free
    end
  end
end
