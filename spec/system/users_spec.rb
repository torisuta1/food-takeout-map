require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) {create(:user)}
  let!(:other_user) {create(:other_user)}

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
                    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
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
                end
              end 
            




