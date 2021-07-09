require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) {create(:user)}

  describe 'sign_up' do
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

              context 'password confirmation' do 
                it 'Registration fails' do 
                  fill_in 'Username', with: 'test'
                  fill_in 'Email', with: 'test@example.com'
                  fill_in 'Password', with: 'password'
                  fill_in 'Password confirmation', with: ''
                  click_on 'Sign up'
                  expect(page).to have_content '1 ERROR PROHIBITED THIS USER FROM BEING SAVED:'
                  end 
                end
              end
            end
