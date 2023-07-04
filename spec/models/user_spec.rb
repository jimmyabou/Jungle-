require 'rails_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with a password and password_confirmation fields' do
      user = User.new(first_name: 'me',
        last_name: 'me',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'password match' do
      user = User.new(password: 'password1', password_confirmation: 'password2')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'password cannot be empty' do
      user = User.new(
        first_name: 'me',
        last_name: 'me',
        email: 'test@test.com',
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'email exists' do
      User.create(
        first_name: 'me',
        last_name: 'me',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        email: 'TEST@TEST.com',
        first_name: 'me',
        last_name: 'me',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
    

    it 'requires email, first name, and last name' do
      user = User.new
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'minimum password length' do
      user = User.new(password: 'pass', password_confirmation: 'pass')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe ' authentication ' do
    it 'successful authentication' do
      user=User.create(first_name: 'me',
        last_name: 'me',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      userentry=User.authenticate_with_credentials('test@test.com','password')
      expect(userentry).to eq(user)
    end

    it 'nil' do
      user=User.create(first_name: 'me',
        last_name: 'me',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      userentry=User.authenticate_with_credentials('test@test.com','password2')
      expect(userentry).to eq(nil)
    end
    it 'spaces in the email' do
      user=User.create(first_name: 'me',
        last_name: 'me',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end
  
    it 'case sensitivity in email' do
      user=User.create(first_name: 'me',
        last_name: 'me',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('TEST@teST.CoM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
