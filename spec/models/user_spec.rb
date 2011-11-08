require 'spec_helper'

describe User do
  context '#validations' do
    %w(username email).each do |a|
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
    it 'should list all classmates of a user when set from the other end' do
      @mate.add_classmate @user
      @user.classmates.should include @mate
    end
    it 'should not add a relationship multiple times' do
      @user.add_classmate @mate
      @mate.add_classmate @user
      @user.should have(1).classmate
      @mate.should have(1).classmate
    end
    it 'should set the relationship as accepted for the user who initiate the relationship' do
      @user.add_classmate @mate
      @user.relationships.last.accepted?.should be_true
    end
    it 'should set the relationship as not accepted if another user adds you' do
      @user.add_classmate @mate
      @mate.relationships.last.accepted?.should be_false
    end
    it 'should set the relationship accepted when both users have added each other' do
      @user.add_classmate @mate
      @mate.add_classmate @user
      @user.relationships.last.accepted?.should be_true
    end
    it 'should set the relationship accepted when both users have added each other (the other side)' do
      @user.add_classmate @mate
      @mate.add_classmate @user
      @mate.relationships.last.accepted?.should be_true
    end
    context '#pending_classmates' do
      it 'should only deliver not yet accepted classmates'
    end
    context '#accepted_classmates' do
      it 'should only deliver accepted classmates'
    end
  end
end
