require 'rails_helper'

RSpec.describe 'password_change_page' do 
  let!(:user) {create(:user)}

  before do 
    visit edit_user_password_path(reset_password_token: "test")
  end

  context 'change password' do
    it 'existing change your password' do
    expect(page).to have_selector 'h2', text: 'Change your password'
    end
  end

  context 'new password' do
    it 'existing new password' do
    expect(page).to have_content 'New password'
    end
  end

  context 'confirm new password' do
    it 'existing confirm new password' do
    expect(page).to have_content 'Confirm new password'
    end
  end

  context 'change button' do
    it 'existing change button' do
    expect(page).to have_button 'Change my password'
    end
  end

  context 'log_in_link' do
    it 'existing log_inn_link' do
    expect(page).to have_link 'Log in'
    end
  end

  context 'sign_up_link' do
    it 'existing sign_up_link' do
    expect(page).to have_link 'Sign up'
    end
  end

  context 'Authentication email' do
    it 'existing 認証メールが届かない場合' do
    expect(page).to have_link '認証メールが届かない場合'
    end
  end
end