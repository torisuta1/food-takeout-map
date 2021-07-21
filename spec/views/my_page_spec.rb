require 'rails_helper'

RSpec.describe 'my_page' do 
  let(:user) {create(:user,email:"test@example.com")}

  before do 
    user.confirm
    visit new_user_session_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_on 'マイページ'

  end

  context 'edit_user' do
    it 'existing edit user' do 
      expect(page).to have_selector 'h2', text: 'Edit User'
    end
  end

  context 'user_name' do 
    it 'existing Username' do
     expect(page).to have_content 'Username'
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

  context 'password confirmation' do 
    it 'existing Password confirmation' do
      expect(page).to have_content 'Password confirmation'
    end
  end

  context 'current password' do 
    it 'existing current Password' do
      expect(page).to have_content 'Current password'
    end
  end

  context 'sign_up_button' do 
    it 'existing update button' do
      expect(page).to have_button 'Update'
    end
  end

  context 'cancel_account' do
    it 'existing cancel account' do
      expect(page).to have_selector 'h3', text: 'Cancel my account'
    end
  end

  context 'cancel_account_button' do 
    it 'existing cancel button' do
      expect(page).to have_button 'Cancel my account'
    end
  end
end