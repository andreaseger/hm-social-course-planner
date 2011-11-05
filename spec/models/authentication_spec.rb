require 'spec_helper'

describe Authentication do
  let(:authhash) { { 'provider' => 'test', 'uid' => '21d23dw653', 'info' => {'name' => 'foo', 'email' => 'bar@test.com'} } }
  context '#find_from_hash' do
    it 'should search by provider and uid' do
      Authentication.expects(:find_by_provider_and_uid)
      Authentication.find_from_hash authhash
    end
  end
  context '#create_from_hash' do
    context '#with existing user' do
      before :each do
        @user = FactoryGirl.create(:user)
      end
      it 'should link the newly created authentication to the existing user' do
        expect{Authentication.create_from_hash(authhash, @user)}.to change{@user.authentications.count}.from(0).to(1)
      end
    end
    context '#without existing user' do
      it 'should create a new user' do
        expect{Authentication.create_from_hash(authhash, nil)}.to change{User.count}.from(0).to(1)
      end
      it 'should link the authentication to the newly created user' do
        a = Authentication.create_from_hash(authhash, nil)
        User.last.authentications.should include(a)
      end
    end
  end
end
