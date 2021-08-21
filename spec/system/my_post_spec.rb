require 'rails_helper'

RSpec.describe 'My_post', type: :system do
  describe 'my_post' do 
    let!(:post) {create(:post)}
    let!(:post3) {create(:post3)}

    before do
      visit root_path
      click_on 'ログイン'
      fill_in 'メールアドレス', with: 'hogefuga1@example.com'
      fill_in 'パスワード', with: 'password2'
      click_button 'ログイン'
    end

    it 'my posts are displayed correctly' do 
      click_on 'navbarDropdown'
      click_on '投稿する'
      fill_in 'new-store-name', with: 'test'
      fill_in 'new-review', with: 'test'
      select '~1500円', from: '価格帯(必須）'
      click_on '投稿'
      click_on 'navbarDropdown'
      click_on 'マイ投稿'
      expect(page).to have_content '店名: test'
      expect(page).to have_content 'レビュー: hoge_review'
      date = DateTime.now
      expect(page).to have_content "投稿日: #{date.strftime("%Y年 %m月 %d日 %H時 %M分")}"
      expect(page).to have_content 'いいね件数: 1'
      expect(page).to have_link '削除'
      expect(page).to have_content '店名: test'
      expect(page).to have_content 'レビュー: test'
    end

    it 'other people is posts will not be displayed' do 
      click_on 'navbarDropdown'
      click_on 'マイ投稿'
      expect(page).to_not have_content '店名: piyo'
      expect(page).to_not have_content 'レビュー: test_review'
    end

    it 'deleted normally' do 
      click_on 'navbarDropdown'
      click_on 'マイ投稿'
      click_on '削除'
      page.accept_confirm   
      expect(page).to have_content '投稿が削除されました'
      expect(page).to_not have_content '店名: test'
    end
  end
end



