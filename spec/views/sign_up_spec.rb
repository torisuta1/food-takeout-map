require 'rails_helper'

RSpec.describe 'sign_up_page' do 
  before do 
    visit new_user_registration_path
  end

  context 'sign_up' do
    it 'existing SIGN UP' do
    expect(page).to have_selector 'h2', text: 'SIGN UP'
    end
  end

  context 'user_name' do 
    it 'existing Username' do
    expect(page).to have_content 'Username'
    end
  end

  context 'Email' do 
    it 'existing Email' do
    expect(page).to have_content 'Email'
    end
  end

  context 'Password' do 
    it 'existing Password' do
    expect(page).to have_content 'Password'
    end
  end

  context 'user_name' do 
    it 'existing Password confirmation' do
    expect(page).to have_content 'Password confirmation'
    end
  end

  context 'Sign_up_button' do 
    it 'existing Sign_up button' do
    expect(page).to have_button 'Sign up'
    end
  end

  context 'log_in' do 
    it 'existing log_in link' do
    expect(page).to have_link 'Log in'
    end
  end

  context 'log_in' do 
    it 'existing 認証メールが届かない場合' do
    expect(page).to have_link '認証メールが届かない場合'
    end
  end
end