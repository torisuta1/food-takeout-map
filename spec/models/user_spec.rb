require 'rails_helper'

RSpec.describe User, type: :model do
  context 'username,email,password,password confirmation enterd' do
    let(:user) {build(:user)}
    it 'can register' do
      expect(user).to be_valid
    end
  end

  context 'username is not enterd' do
    let(:user) {build(:user, username: "")}
    it 'cannot register' do 
      expect(user).not_to be_valid 
    end
  end

  context 'email is not entered' do 
    let(:user) {build(:user, email: "")}
    it 'cannot register' do 
      expect(user).not_to be_valid 
    end 
  end

  context 'Duplicate email' do 
    let(:user1) {create(:user, email: "usertest@example.com")}
    let(:user2) {build(:user,  email: "usertest@example.com")}
    it 'cannot register' do 
      user1
      expect(user2).not_to be_valid 
    end 
  end
  
  context 'password is not entered' do 
    let(:user) {build(:user, password: "")}
    it 'cannot register' do 
      expect(user).not_to be_valid 
    end 
  end
  
  context 'password confirmation is not entered' do 
    let(:user) {build(:user, password_confirmation: "")}
    it 'cannot register' do 
      expect(user).not_to be_valid 
    end 
  end

  context 'password is less than 6 characters' do 
    let(:user) {build(:user, password_confirmation: "a * 5")}
    it 'cannot register' do 
      expect(user).not_to be_valid 
    end 
  end

  context 'if you do not agree' do 
    let(:user) {build(:user, agreement: false )}
    it 'cannot register' do 
      expect(user).not_to be_valid
    end
  end

  context 'has_many' do 
    it 'has_many posts' do
      expect(User.reflect_on_association(:posts).macro).to eq :has_many
    end
  end

  context 'has_many' do 
    it 'has_many likes' do
      expect(User.reflect_on_association(:likes).macro).to eq :has_many
    end
  end

  context 'has_many' do 
    it 'has_many Relationships' do
      expect(User.reflect_on_association(:relationships).macro).to eq :has_many
    end
  end
end
