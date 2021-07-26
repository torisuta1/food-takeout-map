require 'rails_helper'

RSpec.describe 'log_in_page' do 
  before do 
    visit new_user_session_path
  end

  context 'log_in' do
    it 'existing LOG IN' do
      expect(page).to have_selector 'h2', text: 'ログイン'
    end
  end

  context 'email' do
    it 'existing Email' do
      expect(page).to have_content 'メールアドレス'
    end
  end

  context 'password' do
    it 'existing Password' do
      expect(page).to have_content 'パスワード'
    end
  end

  context 'remember me' do
    it 'existing Remember me' do
      expect(page).to have_content '次回から自動的にログイン'
    end
  end

  context 'check_box' do
    it 'existing check_box' do
      expect(page).to have_field ('次回から自動的にログイン')
    end
  end

  context 'log_in_button' do
    it 'existing log_in_button' do
      expect(page).to have_button 'ログイン'
    end
  end

  context 'sign_up_link' do
    it 'existing sign_up_link' do
      expect(page).to have_link 'サインアップ'
    end
  end

  context 'password_link' do
    it 'existing Forgot your password?' do
      expect(page).to have_link 'パスワードを忘れた場合'
    end
  end

  context 'Authentication email' do
    it 'existing 認証メールが届かない場合' do
      expect(page).to have_link '認証メールが届かない場合'
    end
  end
end