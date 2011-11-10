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
    it 'should be valid with teachers' do
      FactoryGirl.build(:booking, teachers: FactoryGirl.create_list(:teacher,2) ).should be_valid
    end
  end

  context '#scopes' do
    context '#in_conflict_with' do
      before do
        @booking = FactoryGirl.create(:booking_with_teacher)
        FactoryGirl.create(:booking_with_teacher, timeslot: @booking.timeslot)
        FactoryGirl.create(:booking_with_teacher)
      end

      it 'should deliver bookings with the same timeslot' do
        Booking.in_conflict_with(@booking,true).should have(2).things
      end
      it 'should be availabe through an instance' do
        @booking.find_conflicted(true).should have(2).things
      end
      it 'should have the given instance included' do
        Booking.in_conflict_with(@booking,true).should include @booking
      end

      it 'should not deliver the given instance if parameter is set to false' do
        Booking.in_conflict_with(@booking).should have(1).things
      end
      it 'should do the same from an instance' do
        @booking.find_conflicted.should have(1).things
      end
      it 'should only deliver the other bookings' do
        Booking.in_conflict_with(@booking).should_not include(@booking)
      end

      it 'should also find conflicted booking with an booking_id' do
        Booking.in_conflict_with(@booking.id).should have(1).things
      end
    end

    context '#related_to' do
      before do
        @booking = FactoryGirl.create(:booking_with_teacher)
        FactoryGirl.create(:booking_with_teacher, course: @booking.course)
        FactoryGirl.create(:booking_with_teacher)
      end
      it 'should deliver bookings with the same course' do
        Booking.related_to(@booking,true).should have(2).things
      end
      it 'should be availabe through an instance' do
        @booking.find_related(true).should have(2).things
      end
      it 'should have the given instance included' do
        Booking.related_to(@booking,true).should include(@booking)
      end

      it 'should not deliver the given instance if parameter is set to false' do
        Booking.related_to(@booking).should have(1).things
      end
      it 'should only deliver the other bookings' do
        Booking.related_to(@booking).should_not include(@booking)
      end
      it 'should also find related booking with an booking_id' do
        Booking.related_to(@booking.id).should have(1).things
      end
    end

    context '#in_conflict_with_any_related' do
      before do
        @booking = FactoryGirl.create(:booking_with_teacher)
        @b2 = FactoryGirl.create(:booking_with_teacher, timeslot: @booking.timeslot)
        @b3 = FactoryGirl.create(:booking_with_teacher, course: @booking.course)
        @b4 = FactoryGirl.create(:booking_with_teacher, timeslot: @b3.timeslot)
        FactoryGirl.create(:booking_with_teacher)
      end
      it 'should deliver bookings with the same timeslot as the given one' do
        Booking.in_conflict_with_any_related(@booking).should include @b2
      end
      it 'should deliver bookings with the same timeslot as one of the related ones' do
        Booking.in_conflict_with_any_related(@booking).should include @b4
      end
      it 'should not deliver the given booking' do
        Booking.in_conflict_with_any_related(@booking).should_not include @booking
      end
      it 'should not deliver related bookings' do
        Booking.in_conflict_with_any_related(@booking).should_not include @b3
      end

    end
    context '#without_conflict' do
      before do
        @used = FactoryGirl.create_list(:booking_with_teacher, 2)
        @free = FactoryGirl.create_list(:booking_with_teacher, 2)
      end
      it 'should deliver bookings which are not in conflict with any of the given ones' do
        Booking.without_conflict(@used).should == @free
      end
    end
  end
  context '#accessing scopes from instance' do
    before do
      @booking = FactoryGirl.create(:booking_with_teacher)
    end
    it 'should call "related_to" when called "find_related"' do
      Booking.expects(:related_to).with(@booking,false)
      @booking.find_related
    end
    it 'should call "in_conflict_with" when called "find_conflicted"' do
      Booking.expects(:in_conflict_with).with(@booking,false)
      @booking.find_conflicted
    end
    it 'should call "in_conflict_with_any_related" when called "find_related_with_conflict"' do
      Booking.expects(:in_conflict_with_any_related).with(@booking)
      @booking.find_related_with_conflict
    end
  end
end
