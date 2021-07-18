require 'rails_helper'

RSpec.describe 'log_in_page' do 
  before do 
    visit new_user_session_path
  end

  context 'log_in' do
    it 'existing LOG IN' do
      expect(page).to have_selector 'h2', text: 'Log in'
    end
  end

  context 'email' do
    it 'existing Email' do
      expect(page).to have_content 'Email'
    end
  end

  context 'password' do
    it 'existing Password' do
      expect(page).to have_content 'Password'
    end
  end

  context 'remember me' do
    it 'existing Remember me' do
      expect(page).to have_content 'Remember me'
    end
  end

  context 'check_box' do
    it 'existing check_box' do
      expect(page).to have_field ('Remember me')
    end
  end

  context 'log_in_button' do
    it 'existing log_in_button' do
      expect(page).to have_button 'Log in'
    end
  end

  context 'sign_up_link' do
    it 'existing sign_up_link' do
      expect(page).to have_link 'Sign up'
    end
  end

  context 'password_link' do
    it 'existing Forgot your password?' do
      expect(page).to have_link 'Forgot your password?'
    end
  end

  context 'Authentication email' do
    it 'existing 認証メールが届かない場合' do
      expect(page).to have_link '認証メールが届かない場合'
    end
  end
end