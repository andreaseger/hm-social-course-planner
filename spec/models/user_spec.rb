require 'spec_helper'

describe User do
  context '#validations' do
    %w(username).each do |a|
      it "should have at least a #{a}" do
        FactoryGirl.build(:user, a => nil).should_not be_valid
      end
    end
  end

  context '#roles' do
    it 'should be able to assign roles' do
      u = FactoryGirl.create(:user)
      u.roles = ['admin']
      u.roles.should include('admin')
    end
    it 'should be able to create a user with an initial role' do
      u = FactoryGirl.create(:user, roles: ['admin'] )
      u.roles.should eq(['admin'])
    end
    it 'should be able to check if a user has a specific role' do
      u = FactoryGirl.create(:user, roles: ['admin'])
      u.role?('admin').should be_true
    end
    it 'should be able to find users by role' do
      FactoryGirl.create_list(:user, 5, roles: ['admin'])
      FactoryGirl.create_list(:user, 5)

      User.count.should eq(10)
      User.with_role('admin').count.should eq(5)
    end
  end

  context '#classmates' do
    before do
      @user = FactoryGirl.create(:user)
      @mate = FactoryGirl.create(:user)
    end
    it 'should do nothing if someone wants to classmate itself' do
      @user.add_classmate @user
      @user.classmates.should be_empty
    end
    it 'should list all classmates of a user' do
      @user.add_classmate @mate
      @user.classmates.should include @mate
    end
    it 'should not add a relationship multiple times' do
      @user.add_classmate @mate
      @mate.add_classmate @user
      @user.should have(1).classmate
      @mate.should have(1).classmate
    end
    context '#is_classmate_with' do
      it 'should be true if both have added the other' do
        @user.add_classmate @mate
        @mate.add_classmate @user
        @user.is_classmate_with(@mate).should be_true
      end
      it 'should be true if both have added the other (other side)' do
        @user.add_classmate @mate
        @mate.add_classmate @user
        @mate.is_classmate_with(@user).should be_true
      end
      it "should be false if you have the user approved but the user didn't approve you back" do
        @user.add_classmate @mate
        @user.is_classmate_with(@mate).should be_false
      end
      it "should be false if a user added you but you didn't approve him" do
        @user.add_classmate @mate
        @mate.is_classmate_with(@user).should be_false
      end
    end
    context '#classmate_requests' do
      it 'should not deliver a classmate_request from mate for the user' do
        @user.add_classmate @mate
        @user.classmate_requests.should_not include @mate
      end
      it 'should deliver a classmate_request of the user for the mate' do
        @user.add_classmate @mate
        @mate.classmate_requests.should include @user
      end
      it 'should not deliver a classmate_request if the request got accepted' do
        @user.add_classmate @mate
        @mate.add_classmate @user
        @mate.classmate_requests.should_not include @user
      end

    end
    context '#pending_classmates' do
      it 'should add the mate to the pending_classmates list of the user' do
        @user.add_classmate @mate
        @user.pending_classmates.should include @mate
      end
      it 'should not add the user to the pending_classmate list of the mate' do
        @user.add_classmate @mate
        @mate.pending_classmates.should_not include @user
      end
      it 'should not deliver a user if the relationship is accepted' do
        @user.add_classmate @mate
        @mate.add_classmate @user
        @user.pending_classmates.should_not include @user
      end
    end
    context '#accepted_classmates' do
      it 'should deliver a list of all accepted classmates' do
        @user.add_classmate @mate
        @mate.add_classmate @user
        @user.accepted_classmates.should include @mate
        @mate.accepted_classmates.should include @user
      end
      it 'should not deliver a user if the relationship is only initiated from one end' do
        @user.add_classmate @mate
        @user.accepted_classmates.should_not include @mate
      end
      it 'should not deliver a user if the relationship is only initiated from one end' do
        @user.add_classmate @mate
        @mate.accepted_classmates.should_not include @user
      end
    end
    context 'not_classmate_with' do
      it 'should list users which are not yet your classmate' do
        @user.not_classmate_with.should include @mate
      end
      it 'should not list classmates' do
        @user.add_classmate @mate
        @mate.add_classmate @user
        @user.not_classmate_with.should_not include @mate
      end
    end
  end
end
