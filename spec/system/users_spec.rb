require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) {create(:user)}
  let(:token) { user.send_reset_password_instructions }
  let!(:other_user) {create(:other_user)}
 
  before do 
    ActionMailer::Base.deliveries.clear
  end

  describe 'about sign_up' do
    before do 
      visit new_user_registration_path
    end

    context 'if entered successfully' do 
      it 'Successful registration(Unauthorized)' do 
        fill_in 'Username', with: 'test'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Sign up'
        expect(current_path).to eq root_path
        expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      end 
    end

    context 'abnormal value' do 
      it 'Registration fails' do 
        fill_in 'Username', with: ''
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
        click_on 'Sign up'
        expect(page).to have_content '3 ERRORS PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'username not entered' do 
      it 'Registration fails' do 
        fill_in 'Username', with: ''
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Sign up'
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'email not entered' do 
      it 'Registration fails' do 
        fill_in 'Username', with: 'test'
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Sign up'
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'password not entered' do 
      it 'Registration fails' do 
        fill_in 'Username', with: 'test'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: 'password'
        click_on 'Sign up'
        expect(page).to have_content '2 ERRORS PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'password confirmation not entered' do 
      it 'Registration fails' do 
        fill_in 'Username', with: 'test'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: ''
        click_on 'Sign up'
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'Log in'
        expect(current_path).to eq new_user_session_path
      end 
    end

    context 'transition to the resend authentication email screen' do
      it 'go to the resend authentication email' do
        click_on '認証メールが届かない場合'
        expect(current_path).to eq new_user_confirmation_path
      end 
    end

    context 'send authentication email' do 
      it 'successful authentication' do 
        Devise::Mailer.confirmation_instructions(user)
        expect(ActionMailer::Base.deliveries.size).to eq(1)
        mail = ActionMailer::Base.deliveries.last
        mail_body = mail.body.encoded
        expect(mail_body).to have_link 'Confirm my account'
      end
    end
  end

  describe 'about log_in' do
    before do 
      visit new_user_session_path
      user1 = user
      user1.confirm
    end

    context 'normal input' do 
      it 'successfully logged in' do
        fill_in 'Email', with: 'hoge1@example.com'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        expect(current_path).to eq root_path
        expect(page).to have_content 'Signed in successfully.'
      end 
    end

    context 'email not entered' do 
      it 'login fails' do
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'Invalid Email or password.'
      end 
    end

    context 'password not entered' do 
      it 'login fails' do
        fill_in 'Email', with: 'hoge1@example.com'
        fill_in 'Password', with: ''
        click_on 'Log in'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'Invalid Email or password.'
      end 
    end

    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'Sign up'
        expect(current_path).to eq new_user_registration_path
      end 
    end
    
    context 'go to the password reset screen' do
      it 'go to the password reset screen' do
        click_on 'Forgot your password?'
        expect(current_path).to eq new_user_password_path
      end 
    end

    context 'transition to the resend authentication email screen' do
      it 'go to the resend authentication email' do
        click_on '認証メールが届かない場合'
        expect(current_path).to eq new_user_confirmation_path
      end 
    end      
      
    context 'if unauthenticated' do 
      it 'can not log in' do
        fill_in 'Email', with: 'hogehoge1@example.com'
        fill_in 'Password', with: 'password2'
        click_on 'Log in'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'You have to confirm your email address before continuing.'
      end 
    end

    context 'not registered.' do 
      it 'can not log in' do
        fill_in 'Email', with: 'hogehoge2@example.com'
        fill_in 'Password', with: 'password2'
        click_on 'Log in'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'Invalid Email or password.'
      end 
    end
  end

  describe 'about reset_password' do 
    before do 
      visit new_user_password_path            
    end

    context 'normal input' do 
      it 'transmission successful' do
        fill_in 'Email', with: 'hogehoge1@example.com'
        click_on 'Send me reset password instructions'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'You will receive an email with instructions on how to reset your passwoa few minutes.'
      end
    end

    context 'unentered' do 
      it 'transmission fails' do
        fill_in 'Email', with: ''
        click_on 'Send me reset password instructions'
        expect(current_path).to eq user_password_path
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end
    end

    context 'unsigned email input' do 
      it 'transmission fails' do
        fill_in 'Email', with: 'test@example.com'
        click_on 'Send me reset password instructions'
        expect(current_path).to eq user_password_path
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'Log in'
        expect(current_path).to eq new_user_session_path
      end 
    end
      
    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'Sign up'
        expect(current_path).to eq new_user_registration_path
      end 
    end

    context 'transition to the resend authentication email screen' do
      it 'go to the resend authentication email' do
        click_on '認証メールが届かない場合'
        expect(current_path).to eq new_user_confirmation_path
      end 
    end

    context 'send change email' do 
      it 'successful change' do 
        ActionMailer::Base.deliverie
        user.confirm
        fill_in 'Email', with: 'hoge1@example.com'
        click_on 'Send me reset password instructions'
        expect(ActionMailer::Base.deliveries.size).to eq(2)
        mail = ActionMailer::Base.deliveries.last
        mail_body = mail.body.encoded
        expect(mail_body).to have_link 'Change my password'
      end 
    end
  end

  describe 'about change_password' do 
    before do 
      user.confirm
      visit edit_user_password_path(reset_password_token: token)            
    end
  
    context 'normal input' do 
      it 'successful change' do
        fill_in 'New password', with: 'new-password'
        fill_in 'Confirm new password', with: 'new-password'
        click_on 'Change my password'
        expect(current_path).to eq root_path
        expect(page).to have_content 'Your password has been changed successfully. You are now signed in.'
      end
    end

    context 'Password not entered' do 
      it 'change fails' do
        fill_in 'New password', with: ''
        fill_in 'Confirm new password', with: ''
        click_on 'Change my password'
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'Log in'
        expect(current_path).to eq new_user_session_path
      end 
    end
          
    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'Sign up'
        expect(current_path).to eq new_user_registration_path
      end 
    end
    
    context 'transition to the resend authentication email screen' do
      it 'go to the resend authentication email' do
        click_on '認証メールが届かない場合'
        expect(current_path).to eq new_user_confirmation_path
      end 
    end

    context 'if unauthenticated' do 
      it 'will be changed and prompted for authentication' do 
        other_token = other_user.send_reset_password_instructions 
        visit edit_user_password_path(reset_password_token: other_token)  
        fill_in 'New password', with: 'new-password'
        fill_in 'Confirm new password', with: 'new-password'
        click_on 'Change my password'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Your password has been changed successfully.'
        expect(page).to have_content 'You have to confirm your email address before continuing.'
      end
    end

    context 'token is invalid.' do 
      it 'change fails' do 
        visit edit_user_password_path(reset_password_token: 'invalid_token')  
        fill_in 'New password', with: 'new-password'
        fill_in 'Confirm new password', with: 'new-password'
        click_on 'Change my password'
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end
    end
  end 

  describe 'about resend_email' do 
    before do 
      visit user_confirmation_path            
    end
    context 'normal input' do 
      it 'transmission successful' do
        user
        fill_in 'Email', with: 'hoge1@example.com'
        click_on 'Resend confirmation instructions'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'You will receive an email with instructions for how to confirm your email address in a few minutes.'
      end
    end
        
    context 'email not entered' do 
      it 'resend fails' do
        fill_in 'Email', with: ''
        click_on 'Resend confirmation instructions'
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'unsigned email' do 
      it 'resend fails' do
        fill_in 'Email', with: 'test@example.com'
        click_on 'Resend confirmation instructions'
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end 
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'Log in'
        expect(current_path).to eq new_user_session_path
      end 
    end
            
    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'Sign up'
        expect(current_path).to eq new_user_registration_path
      end 
    end

    context 'go to the password reset screen' do
      it 'go to the password reset screen' do
        click_on 'Forgot your password?'
        expect(current_path).to eq new_user_password_path
      end  
    end
  end

  describe 'about my_page' do 
    let(:user) {create(:user,email:"test@example.com")}

    before do 
      user.confirm
      visit new_user_session_path
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
      click_on 'マイページ'
    end

    context 'normal input' do 
      it 'successful update' do
        fill_in 'Username', with: 'hoge'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'new-password'
        fill_in 'Password confirmation', with: 'new-password'
        fill_in 'Current password', with: 'password'
        click_on 'Update'
        expect(current_path).to eq root_path
        expect(page).to have_content 'Your account has been updated successfully.'
      end
    end

    context 'username not enterd' do 
      it 'update fails' do
        fill_in 'Username', with: ''
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'new-password'
        fill_in 'Password confirmation', with: 'new-password'
        fill_in 'Current password', with: 'password'
        click_on 'Update'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
      end
    end

    context 'Email not enterd' do 
      it 'update fails' do
        fill_in 'Username', with: 'hoge'
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'new-password'
        fill_in 'Password confirmation', with: 'new-password'
        fill_in 'Current password', with: 'password'
        click_on 'Update'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'    
      end
    end
   
    context 'password not enterd' do 
      it 'update fails' do
        fill_in 'Username', with: 'hoge'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: 'new-password'
        fill_in 'Current password', with: 'password'
        click_on 'Update'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '2 ERRORS PROHIBITED THIS USER FROM BEING SAVED:'
      end
    end

    context 'password confirmation not enterd' do 
      it 'update fails' do
        fill_in 'Username', with: 'hoge'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'new-password'
        fill_in 'Password confirmation', with: ''
        fill_in 'Current password', with: 'password'
        click_on 'Update'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'    
      end
    end

    context 'password not enterd & current password normal input' do 
      it 'successful update' do
        fill_in 'Username', with: 'hoge1'
        fill_in 'Email', with: 'test1@example.com'
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
        fill_in 'Current password', with: 'password'
        click_on 'Update'
        expect(current_path).to eq root_path
        expect(page).to have_content 'You updated your account successfully, but we need to verify your new email address. Please check your email and follow the confirmation link to confirm your new email address.'    
      end
    end

    context 'current password not enterd' do 
      it 'update falis' do
        fill_in 'Username', with: 'hoge'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'new-password'
        fill_in 'Password confirmation', with: 'new-password'
        fill_in 'Current password', with: ''
        click_on 'Update'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'    
      end
    end

    context 'abnormal value input' do 
      it 'update falis' do
        fill_in 'Username', with: 'hoge'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'new-password'
        fill_in 'Password confirmation', with: 'new-password'
        fill_in 'Current password', with: ''
        click_on 'Update'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'    
      end
    end

    context 'delete Account' do 
      it 'account will be deleted.' do 
        click_on 'Cancel my account'
        page.accept_confirm   
        expect(current_path).to eq root_path
        expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
      end
    end

    context 'not logged in' do 
      it 'will be asked to log in' do 
        click_on 'ログアウト'
        visit edit_user_registration_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
            




