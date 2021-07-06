require 'rails_helper'

RSpec.describe 'sign_up_page' do 
  describe 'sign_up' do 
    it 'existing SIGN UP' do
    visit new_user_registration_path
    expect(page).to have_selector 'h2', text: 'SIGN UP'
    end
  end

  describe 'user_name' do 
    it 'existing Username' do
    visit new_user_registration_path
    expect(page).to have_content 'Username'
    end
  end

  describe 'Email' do 
    it 'existing Email' do
    visit new_user_registration_path
    expect(page).to have_content 'Email'
    end
  end

  describe 'Password' do 
    it 'existing Password' do
    visit new_user_registration_path
    expect(page).to have_content 'Password'
    end
  end

  describe 'user_name' do 
    it 'existing Password confirmation' do
    visit new_user_registration_path
    expect(page).to have_content 'Password confirmation'
    end
  end

  describe 'Sign_up_button' do 
    it 'existing Sign_up button' do
    visit new_user_registration_path
    expect(page).to have_button 'Sign up'
    end
  end

  describe 'log_in' do 
    it 'existing log_in link' do
    visit new_user_registration_path
    expect(page).to have_link 'Log in'
    end
  end

  describe 'log_in' do 
    it 'existing 認証メールが届かない場合' do
    visit new_user_registration_path
    expect(page).to have_link '認証メールが届かない場合'
    end
  end
end