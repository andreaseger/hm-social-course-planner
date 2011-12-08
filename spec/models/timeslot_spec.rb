require 'spec_helper'

describe Timeslot do
  context '#validation' do
    %w(start_label start_minute start_hour end_label end_minute end_hour day).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:timeslot, a => nil).should_not be_valid
      end
    end
    %w(start_hour end_hour).each do |a|
      it "should check that #{a} is always greater or equal 0" do
        FactoryGirl.build(:timeslot, a => -5).should_not be_valid
      end
      it "should check that #{a} is always less than 24" do
        FactoryGirl.build(:timeslot, a => 25).should_not be_valid
      end
    end
    %w(start_minute end_minute).each do |a|
      it "should check that #{a} is always greater or equal 0" do
        FactoryGirl.build(:timeslot, a => -5).should_not be_valid
      end
      it "should check that #{a} is always less than 60" do
        FactoryGirl.build(:timeslot, a => 65).should_not be_valid
      end
    end
  end
  context "#start_time" do
    it 'should make one integer out of minutes and hour' do
      FactoryGirl.build(:timeslot, start_hour: 10, start_minute: 00, end_hour: 11, end_minute: 30).start_time.should == 1000
    end
  end
  context "#end_time" do
    it 'should make one integer out of minutes and hour' do
      FactoryGirl.build(:timeslot, start_hour: 8, start_minute: 15, end_hour: 9, end_minute: 45).end_time.should == 945
    end
  end
  context '#self.current_timeslots' do
    before :each do
      wed = FactoryGirl.create(:day, id: 3, name: 'mi', label: 'Mittwoch')
      thu = FactoryGirl.create(:day, id: 4, name: 'do', label: 'Donnerstag')
      @slots = [wed,thu].inject({}) do |hash,d|
        hash[d.name] ||= {}
        hash[d.name].merge! 815 => FactoryGirl.create(:timeslot, day: d,  start_hour: 8, start_minute: 15, end_hour: 9, end_minute: 45 )
        hash[d.name].merge! 1000 => FactoryGirl.create(:timeslot, day: d, start_hour: 10, start_minute: 0, end_hour: 11, end_minute: 30 )
        hash[d.name].merge! 1145 => FactoryGirl.create(:timeslot, day: d, start_hour: 11, start_minute: 45, end_hour: 13, end_minute: 15 )
        #hash[d.name].merge! 1330 => FactoryGirl.create(:timeslot, day: d, start_hour: 13, start_minute: 30, end_hour: 15, end_minute: 00 )
        #hash[d.name].merge! 1515 => FactoryGirl.create(:timeslot, day: d, start_hour: 15, start_minute: 15, end_hour: 16, end_minute: 45 )
        hash
      end
    end
    context 'at 10:05' do
      before :each do
        @time = Time.local(2011, 12, 07, 10, 5, 0) #wednesday at around 10:05
      end
      it 'should return the the timeslot wednesday starting at 10:00' do
        Timecop.travel(@time) do
          Timeslot.now.should include(@slots['mi'][1000])
        end
      end
      it 'should not return the 8:15 timeslot on wednesday' do
        Timecop.travel(@time) do
          Timeslot.now.should_not include(@slots['mi'][815])
        end
      end
      it 'should not return any thursday timelost' do
        Timecop.travel(@time) do
          Timeslot.now.should_not include(@slots['do'][815])
          Timeslot.now.should_not include(@slots['do'][1000])
        end
      end
    end
    context 'outside normal course time' do
      context 'at 11:40' do
        before :each do
          @time = Time.local(2011, 12, 07, 11, 40, 0) #wednesday at around 11:40
        end
        it 'should return the the timeslot wednesday starting at 11:45' do
          Timecop.travel(@time) do
            Timeslot.now.should include(@slots['mi'][1145])
          end
        end
        it 'should return the the timeslot wednesday starting at 10:00' do
          Timecop.travel(@time) do
            Timeslot.now.should include(@slots['mi'][1000])
          end
        end
        it 'should not return the 8:15 timeslot on wednesday' do
          Timecop.travel(@time) do
            Timeslot.now.should_not include(@slots['mi'][815])
          end
        end
      end
      context 'at 9:50' do
        before :each do
          @time = Time.local(2011, 12, 07, 9, 50, 0) #wednesday at around 9:50
        end
        it 'should return the the timeslot wednesday starting at 10:00' do
          Timecop.travel(@time) do
            Timeslot.now.should include(@slots['mi'][1000])
          end
        end
        it 'should not return the 8:15 timeslot on wednesday' do
          Timecop.travel(@time) do
            Timeslot.now.should include(@slots['mi'][815])
          end
        end
        it 'should not return the 10:00 timeslot on wednesday' do
          Timecop.travel(@time) do
            Timeslot.now.should_not include(@slots['mi'][1145])
          end
        end
      end
    end
  end
end
