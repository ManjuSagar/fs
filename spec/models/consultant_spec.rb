require 'spec_helper'

describe Consultant do

  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consultant, first_name: nil), :first_name

  it 'is invalid when a first_name has more than 100 characters' do
    FactoryGirl.build(:consultant, first_name: 'a'*101).should_not be_valid
  end

  it 'is invalid when a last_name has more than 100 characters' do
    FactoryGirl.build(:consultant, last_name: 'a'*101).should_not be_valid
  end

  it_behaves_like 'is invalid without the field', FactoryGirl.build(:consultant, last_name: nil), :last_name

  it_behaves_like 'is valid without the field', FactoryGirl.build(:consultant, phone_number: nil), :phone_number

  it 'is invalid when zip_code length exceeds 5 ' do
    FactoryGirl.build(:consultant, zip_code: '90013').zip_code.length.should <= 5
  end

  it 'is invalid without Zip Code in the address' do
    FactoryGirl.build(:consultant, zip_code: nil)
  end

  it 'is invalid if street_address is having more than 50 characters' do
    FactoryGirl.build(:consultant, street_address: "101MS" * 10).street_address.length.should <= 50
  end

  it 'is invalid if suite_number is having more than 10 characters' do
    FactoryGirl.build(:consultant, suite_number: "9283989889").suite_number.length.should <= 10
  end

  it 'is invalid if city is having more than 50 characters' do
    FactoryGirl.build(:consultant, city: 'b' * 50).city.length.should <= 50
  end

  it 'should require password ' do
    FactoryGirl.build(:consultant, password: nil, password_confirmation: nil).should_not be_valid
  end

  it "should require a matching password confirmation" do
    FactoryGirl.build(:consultant, password: 'test1234', password_confirmation: "test").should_not be_valid
  end

  it "should reject short passwords" do
    FactoryGirl.build(:consultant,password: 'a'*5, password_confirmation: 'a' * 5).should_not be_valid
  end

  it 'returns consultant full name ' do
    consultant = FactoryGirl.build(:consultant, first_name: 'Jhon', last_name: 'Doe')
    consultant.full_name.should == 'Jhon Doe'
    consultant.to_s.should == 'Jhon Doe'
  end

  it 'should return full address' do
    consultant = FactoryGirl.build(:consultant)
    consultant.address_string.should == "#{consultant.street_address} #{consultant.suite_number}, #{consultant.city}, #{consultant.state}, #{consultant.zip_code}"
  end

  it 'should return location' do
    consultant = FactoryGirl.build(:consultant)
    consultant.location.should == "#{consultant.street_address}, #{consultant.suite_number}, #{consultant.city}, #{consultant.state}, #{consultant.zip_code}"
  end

  it 'should return Male or Female' do
    consultant = FactoryGirl.build(:consultant, gender: 'F')
    ['Female', 'Male'].should include(consultant.gender_string)
  end

  it 'should return phone number without seperator' do
    consultant = FactoryGirl.build(:consultant, phone_number: '(323) 258-7412')
    consultant.phone_number_without_separator.should == 3232587412
  end

  it "should return phone numbers " do
    consultant = FactoryGirl.build(:consultant, phone_number: '(323) 258-7412', phone_number_2: '(323) 258-7412')
    consultant.phone_numbers.should == ['(323) 258-7412', '(323) 258-7412']
  end

  it "should have encrypted password" do
    consultant = FactoryGirl.create(:consultant, password: 'test1234', password_confirmation: 'test1234')
    consultant.encrypted_password.should_not be_nil
  end

  it 'does not required zip code ' do
    consultant = FactoryGirl.build(:consultant)
    consultant.zip_code_required?.should be_false
  end

  context 'role' do
    let(:consultant) {FactoryGirl.build(:consultant)}
    subject{consultant}
    its(:super_admin?) {User.current = subject;should be_false}
    its(:field_staff?) {User.current = subject;should be_false}
    its(:consultant?) {User.current = subject;should be_true}
    its(:office_staff?) {User.current = subject;should be_false}
    its(:patient?) {User.current = subject;should be_false}
  end

 it 'resets password' do
   consultant = FactoryGirl.build(:consultant)
   consultant.reset_user_password.should be_true
 end

 it 'profile should be complete' do
   consultant = FactoryGirl.build(:consultant)
   consultant.user_profile_completed?.should be_true
 end

 it 'password confimation is required' do
   consultant = FactoryGirl.build(:consultant, password: 'test1234', password_confirmation: nil)
   consultant.should have(1).errors_on(:password_confirmation)
 end

end
