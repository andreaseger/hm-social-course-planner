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
    it 'should be able to set a link between two users'
    it 'should list all classmates of a user'
  end
end
