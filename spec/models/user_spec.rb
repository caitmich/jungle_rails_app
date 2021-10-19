require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @name = 'Joe'
    @email = 'email@email.com'
    @password = 'secretpassword'
  end

  describe 'Validations' do 
    describe '.create' do

      it 'does not create a user when name is not present' do
        @user = User.create(name: @nil, email:@email, password:@password, password_confirmation: @password)
        expect(@user.validate).to be false
      end
      
      it 'does not create a user when password is not present' do
        @user = User.create(name: @name, email:@email, password:nil, password_confirmation: @password)
        expect(@user.validate).to be false
      end

      it 'does not create a user when password_confirmation is not present' do
        @user = User.create(name: @name, email:@email, password:@password, password_confirmation: nil)
        expect(@user.validate).to be false
      end

      it 'does not create a user when password and password_confirmation do not match' do
        @user = User.create(name: @name, email:@email, password:@password, password_confirmation:'differentpassword')
        expect(@user.validate).to be false
      end

      it 'does not create a user when the email is already in use' do
        @user = User.create(name: @name, email:@email, password:@password, password_confirmation:@password)
        @user2 = User.new(name: @name, email:@email, password:@password, password_confirmation:@password)
        @user2.save
        expect(@user2.validate).to be false
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end

      it 'does not create a user when email is repeated with different character cases' do
        @user = User.create!(name: @name, email:'email@email.com', password: @password, password_confirmation: @password)
        @user2 = User.new(name: @name, email: 'EMAIL@email.com', password: @password, password_confirmation: @password)
        @user2.save
        expect(@user2.validate).to be false
        expect(@user2.errors.full_messages).to eq(["Email has already been taken"])
      end

      it 'does not allow a password less than 8 characters' do
        @user = User.create(name: @name, email:@email, password:"pass", password_confirmation: "pass")
        expect(@user.validate).to be false
        expect(@user.errors.full_messages).to eq(["Password is too short (minimum is 8 characters)"])
      end

    end

  end

  describe '.authenticate_with_credentials' do

    it 'successfully logs in a user when authentications pass' do
      @user = User.create!(name: @name, email:@email, password: @password, password_confirmation: @password)
      expect(User.authenticate_with_credentials(@email, @password)).to eq(@user)
    end

    it 'still logs in a user if spaces are included in email field' do
      @user = User.create!(name: @name, email:'email@email.com', password: @password, password_confirmation: @password)

      expect(User.authenticate_with_credentials(' email@email.com ', @password)
      ).to eq(@user)
    end

    it 'still logs in a user if case is changed in email field' do
      @user = User.create!(name: @name, email:'email@email.com', password: @password, password_confirmation: @password)

      expect(User.authenticate_with_credentials('EMAIL@emAil.coM', @password)
      ).to eq(@user)
    end

  end

end
