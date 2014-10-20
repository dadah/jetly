require 'rails_helper'

describe User do

  describe '#create' do

    it 'validates password confirmation' do
      user = User.create email: 'test@test.tst', password: 'somepass', password_confirmation: 'faaaail'
      expect(user.errors).to have_key :password_confirmation
    end

  end
end
