require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) {create(:user)}

  describe 'sign_up' do
    context 'If entered successfully' do 
      it 'Successful registration(Unauthorized)' do 
        visit new_user_registration_path
        fill_in 'Username', with: 'test'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Sign up'
        expect(current_path).to eq root_path
        expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
        end 
      end
    end 
  end
