require 'rails_helper'

RSpec.describe 'My_page', type: :system do
  describe 'my_page' do 
    let!(:post2) {create(:post2)}
    let!(:post3) {create(:post3)}

    before do
      visit root_path
      click_on 'ログイン'
      fill_in 'メールアドレス', with: 'hogefuga1@example.com'
      fill_in 'パスワード', with: 'password2'
      click_button 'ログイン'
      click_on 'マイページ'
    end

    context 'user submissions' do
      it 'my user information and posts are displayed' do 
        expect(page).to have_content 'ユーザー投稿一覧'
        expect(page).to have_content '店名: hoge'
        expect(page).to have_content 'レビュー: fuga_review'
        date = DateTime.now
        expect(page).to have_content "投稿日: #{date.strftime("%Y年 %m月 %d日 %H時 %M分")}"
        expect(page).to have_content '投稿者:'
        expect(page).to have_link 'hoge3'
        expect(page).to have_content 'いいね件数:  0'
        expect(page).to have_button 'like-button-user-show'
        expect(page).to have_content 'いいねしたユーザー'
      end
    end

    context 'like function' do 
      it 'Functioning normally' do 
        click_button 'like-button-user-show'
        expect(page).to have_content 'いいね件数:  1'
        expect(page).to have_link('hoge3', count: 2)
      end
    end

    context 'user profile' do 
      it 'user information is displayed' do 
        expect(page).to have_content 'ユーザーネーム: hoge3'
        expect(page).to have_content 'プロフィール:'
        expect(page).to have_content 'test'
      end
    end

    context 'posts I am liking' do 
      it 'Displayed normally' do 
        click_button 'like-button-user-show'
        visit current_path
        expect(page).to have_link 'hoge'
        click_on 'hoge'
        expect(current_path).to eq post_path(post2)
      end
    end

    context 'follow list' do 
      it 'functioning normally' do 
        click_on 'フォロワー: 1'
        click_link 'hoge'
        expect(page).to have_content 'ユーザーネーム: hoge'
      end
    end

    context 'following list' do 
      it 'functioning normally' do
        click_on 'フォロー: 1'
        click_link 'hoge'
        expect(page).to have_content 'ユーザーネーム: hoge'
      end
    end

    context 'follow button' do
      it 'will not appear on your own my page' do 
        expect(page).to_not have_button 'フォロー'
        expect(page).to_not have_button 'フォロー解除'
      end
    end

    context 'follow button' do
      it 'shows up on other people is my page' do 
        visit posts_path
        click_on 'hoge2'
        expect(page).to have_button 'フォロー'
      end
    end

    context 'when not logged in' do
      it 'follow button is not displayed on the user details screen' do 
        click_on 'ログアウト'
        visit posts_path
        click_on 'hoge2'
        expect(page).to_not have_button 'フォロー'
        expect(page).to_not have_button 'フォロー解除'
      end
    end
  end
end