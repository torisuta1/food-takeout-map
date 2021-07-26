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
        fill_in 'ユーザーネーム', with: 'test'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on 'サインアップ'
        expect(current_path).to eq root_path
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      end 
    end

    context 'abnormal value' do 
      it 'Registration fails' do 
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: ''
        click_on 'サインアップ'
        expect(page).to have_content '3 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'username not entered' do 
      it 'Registration fails' do 
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on 'サインアップ'
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'email not entered' do 
      it 'Registration fails' do 
        fill_in 'ユーザーネーム', with: 'test'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on 'サインアップ'
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'password not entered' do 
      it 'Registration fails' do 
        fill_in 'ユーザーネーム', with: 'test'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: 'password'
        click_on 'サインアップ'
        expect(page).to have_content '2 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'password confirmation not entered' do 
      it 'Registration fails' do 
        fill_in 'ユーザーネーム', with: 'test'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: ''
        click_on 'サインアップ'
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'ログイン'
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
        expect(mail_body).to have_link 'アカウントを認証する'
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
        fill_in 'メールアドレス', with: 'hoge1@example.com'
        fill_in 'パスワード', with: 'password'
        click_on 'ログイン'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ログインしました。'
      end 
    end

    context 'email not entered' do 
      it 'login fails' do
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        click_on 'ログイン'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
      end 
    end

    context 'password not entered' do 
      it 'login fails' do
        fill_in 'メールアドレス', with: 'hoge1@example.com'
        fill_in 'パスワード', with: ''
        click_on 'ログイン'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
      end 
    end

    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'サインアップ'
        expect(current_path).to eq new_user_registration_path
      end 
    end
    
    context 'go to the password reset screen' do
      it 'go to the password reset screen' do
        click_on 'パスワードを忘れた場合'
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
        fill_in 'メールアドレス', with: 'hogehoge1@example.com'
        fill_in 'パスワード', with: 'password2'
        click_on 'ログイン'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'メールアドレスの本人確認が必要です。'
      end 
    end

    context 'not registered.' do 
      it 'can not log in' do
        fill_in 'メールアドレス', with: 'hogehoge2@example.com'
        fill_in 'パスワード', with: 'password2'
        click_on 'ログイン'
        expect(current_path).to eq user_session_path
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
      end 
    end
  end

  describe 'about reset_password' do 
    before do 
      visit new_user_password_path            
    end

    context 'normal input' do 
      it 'transmission successful' do
        fill_in 'メールアドレス', with: 'hogehoge1@example.com'
        click_on 'パスワードリセットメールを送信'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
      end
    end

    context 'unentered' do 
      it 'transmission fails' do
        fill_in 'メールアドレス', with: ''
        click_on 'パスワードリセットメールを送信'
        expect(current_path).to eq user_password_path
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end
    end

    context 'unsigned email input' do 
      it 'transmission fails' do
        fill_in 'メールアドレス', with: 'test@example.com'
        click_on 'パスワードリセットメールを送信'
        expect(current_path).to eq user_password_path
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'ログイン'
        expect(current_path).to eq new_user_session_path
      end 
    end
      
    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'サインアップ'
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
        fill_in 'メールアドレス', with: 'hoge1@example.com'
        click_on 'パスワードリセットメールを送信'
        expect(ActionMailer::Base.deliveries.size).to eq(2)
        mail = ActionMailer::Base.deliveries.last
        mail_body = mail.body.encoded
        expect(mail_body).to have_link 'パスワード変更'
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
        fill_in '新パスワード', with: 'new-password'
        fill_in 'パスワード確認', with: 'new-password'
        click_on 'パスワード変更'
        expect(current_path).to eq root_path
        expect(page).to have_content 'パスワードが正しく変更されました。'
      end
    end

    context 'password not entered' do 
      it 'change fails' do
        fill_in '新パスワード', with: ''
        fill_in 'パスワード確認', with: ''
        click_on 'パスワード変更'
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'ログイン'
        expect(current_path).to eq new_user_session_path
      end 
    end
          
    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'サインアップ'
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
        fill_in '新パスワード', with: 'new-password'
        fill_in 'パスワード確認', with: 'new-password'
        click_on 'パスワード変更'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'パスワードが正しく変更されました。'
        expect(page).to have_content 'メールアドレスの本人確認が必要です。'
      end
    end

    context 'token is invalid.' do 
      it 'change fails' do 
        visit edit_user_password_path(reset_password_token: 'invalid_token')  
        fill_in '新パスワード', with: 'new-password'
        fill_in 'パスワード確認', with: 'new-password'
        click_on 'パスワード変更'
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
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
        fill_in 'メールアドレス', with: 'hoge1@example.com'
        click_on '認証メール再送'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'あなたのメールアドレスが登録済みの場合、本人確認用のメールが数分以内に送信されます。'
      end
    end
        
    context 'email not entered' do 
      it 'resend fails' do
        fill_in 'メールアドレス', with: ''
        click_on '認証メール再送'
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'unsigned email' do 
      it 'resend fails' do
        fill_in 'メールアドレス', with: 'test@example.com'
        click_on '認証メール再送'
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end 
    end

    context 'transition to the login screen' do
      it 'go to the login screen' do
        click_on 'ログイン'
        expect(current_path).to eq new_user_session_path
      end 
    end
            
    context 'go to the sign-up screen' do
      it 'go to the sign-up screen' do
        click_on 'サインアップ'
        expect(current_path).to eq new_user_registration_path
      end 
    end

    context 'go to the password reset screen' do
      it 'go to the password reset screen' do
        click_on 'パスワードを忘れた場合'
        expect(current_path).to eq new_user_password_path
      end  
    end
  end

  describe 'about my_page' do 
    let(:user) {create(:user,email:"test@example.com")}

    before do 
      user.confirm
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_on 'ログイン'
      click_on 'マイページ'
    end

    context 'normal input' do 
      it 'successful update' do
        fill_in 'ユーザーネーム', with: 'hoge'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'new-password'
        fill_in '確認用パスワード', with: 'new-password'
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(current_path).to eq root_path
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end

    context 'username not enterd' do 
      it 'update fails' do
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'new-password'
        fill_in '確認用パスワード', with: 'new-password'
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'
      end
    end

    context 'email not enterd' do 
      it 'update fails' do
        fill_in 'ユーザーネーム', with: 'hoge'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'new-password'
        fill_in '確認用パスワード', with: 'new-password'
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'    
      end
    end
   
    context 'password not enterd' do 
      it 'update fails' do
        fill_in 'ユーザーネーム', with: 'hoge'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: 'new-password'
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '2 件のエラーが発生したため USER は保存されませんでした:'
      end
    end

    context 'password confirmation not enterd' do 
      it 'update fails' do
        fill_in 'ユーザーネーム', with: 'hoge'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'new-password'
        fill_in '確認用パスワード', with: ''
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'    
      end
    end

    context 'password not enterd & current password normal input' do 
      it 'successful update' do
        fill_in 'ユーザーネーム', with: 'hoge1'
        fill_in 'メールアドレス', with: 'test1@example.com'
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: ''
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(current_path).to eq root_path
        expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'    
      end
    end

    context 'current password not enterd' do 
      it 'update falis' do
        fill_in 'ユーザーネーム', with: 'hoge'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'new-password'
        fill_in '確認用パスワード', with: 'new-password'
        fill_in '現在のパスワード', with: ''
        click_on '更新'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'    
      end
    end

    context 'abnormal value input' do 
      it 'update falis' do
        fill_in 'ユーザーネーム', with: 'hoge'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'new-password'
        fill_in '確認用パスワード', with: 'new-password'
        fill_in '現在のパスワード', with: ''
        click_on '更新'
        expect(current_path).to eq user_registration_path
        expect(page).to have_content '1 件のエラーが発生したため USER は保存されませんでした:'    
      end
    end

    context 'delete Account' do 
      it 'account will be deleted.' do 
        click_on 'アカウント削除'
        page.accept_confirm   
        expect(current_path).to eq root_path
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
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
            




