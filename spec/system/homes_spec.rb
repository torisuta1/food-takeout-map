require 'rails_helper'

RSpec.describe 'Home', type: :system do
  before do 
    visit root_path
  end

  describe 'when not logged in' do 
    context 'guest_log_in' do 
      it 'guest login is available' do 
        click_link 'ゲストログイン（閲覧用）'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end
    end

    context 'log_in' do 
      it 'login is available' do 
        click_link 'ログイン'
        expect(current_path).to eq new_user_session_path
      end
    end

    context 'sign_up' do 
      it 'sign_up is available' do 
        click_link 'サインアップ'
        expect(current_path).to eq new_user_registration_path
      end
    end

    context 'search' do 
      it 'search is available' do 
        click_on 'navbarDropdown'
        click_link '検索'
        expect(current_path).to eq search_posts_path
      end
    end

    context 'lists' do 
      it 'lists is available' do 
        click_on 'navbarDropdown'
        click_link '一覧'
        expect(current_path).to eq posts_path
      end
    end

    context 'submit' do 
      it 'submit is available' do 
        click_on 'navbarDropdown'
        click_link '投稿する'
        expect(current_path).to eq new_post_path
      end
    end

    context 'home' do 
      it 'home is available' do 
        click_on 'navbarDropdown'
        click_link 'ホーム'
        expect(current_path).to eq root_path
      end
    end

    context 'terms of use' do 
      it 'Terms of Use is available' do 
        click_link '利用規約'
        expect(page).to have_selector 'h3', text: '利用規約'
      end
    end

    context 'privacy policy' do 
      it 'privacy policy is available' do 
        click_link 'プライバシーポリシー'
        expect(page).to have_selector 'h3', text: 'プライバシーポリシー'
      end
    end
  end

  describe 'when logged in' do 
    before do 
      visit root_path
      click_link 'ゲストログイン（閲覧用）'
    end 

    context 'log_out' do 
      it 'existing ログアウト' do 
        expect(page).to have_selector 'li', text: 'ログアウト'
      end
    end

    context 'my_page' do 
      it 'existing マイページ' do 
        expect(page).to have_selector 'li', text: 'マイページ'
      end
    end

    context 'log_out' do 
      it 'existing ログアウト' do 
        expect(page).to have_selector 'li', text: 'ログアウト'
      end
    end

    context 'my_posts' do 
      it 'my_posts is available' do 
        click_on 'navbarDropdown'
        click_link 'マイ投稿'
        expect(page).to have_selector 'h2', text: 'My Posted Articles'
      end
    end

    context 'user_edit' do 
      it 'user_edit is available' do 
        click_on 'navbarDropdown'
        click_link 'ユーザー編集'
        expect(current_path).to eq edit_user_registration_path
      end
    end
  end
end