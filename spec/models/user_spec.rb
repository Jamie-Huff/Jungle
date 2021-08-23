require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'Should exist, if filled out properly' do
      @user = User.new(first_name: 'billy', last_name: 'bob', email: 'billybob@email.com', password: 'thisTest', password_confirmation: 'thisTest')
      expect(@user).to be_valid
      puts @user.errors.full_messages
    end

    it 'needs password and password_confirmation to be the same' do
      @user = User.new(first_name: 'billy', last_name: 'bob', email: 'billybob@email.com', password: 'thisTest', password_confirmation: 'otherString')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end
      
    it 'email must not already exist in the database' do
      @user1 = User.new(first_name: 'billy', last_name: 'bob', email: 'billybob@email.com', password: 'thisTest', password_confirmation: 'thisTest')
      @user1.save
      @user2 = User.new(first_name: 'billy', last_name: 'bob', email: 'billybob@email.com', password: 'thisTest', password_confirmation: 'thisTest')
      @user2.save
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end
    
    it 'should have a first name' do
      @user = User.new(first_name: nil, last_name: 'bob', email: 'billybob@email.com', password: 'thisTest', password_confirmation: 'thisTest')
      expect(@user).to_not be_valid
    end

    it 'should have a last name' do
      @user = User.new(first_name: 'billy', last_name: nil, email: 'billybob@email.com', password: 'thisTest', password_confirmation: 'thisTest')
      expect(@user).to_not be_valid
    end
      
    it 'should have an email' do
      @user = User.new(first_name: 'billy', last_name: 'bob', email: nil, password: 'thisTest', password_confirmation: 'thisTest')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end

    it 'should have a password of at least 5 characters' do
      @user = User.new(first_name: 'billy', last_name: 'bob', email: 'bob@bob.com', password: '22', password_confirmation: '22')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 3 characters)")
    end
  end
end
