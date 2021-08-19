require 'rails_helper'

RSpec.describe 'Search', type: :system do
  let!(:genre) {create(:genre)}
  let!(:post) {create(:post)}
  let!(:post2) {create(:post2)}

  

  fdescribe 'When not logged in' do 
    before do 
      visit search_posts_path
    end
    context 'if no input' do 
      it 'view all posts' do 
        click_on '検索'
        expect(page).to have_content '検索条件が指定されていません、全投稿を表示します。'
        expect(page).to have_content '店名: test'
        expect(page).to have_content 'レビュー: hoge_review'
        date = DateTime.now
        expect(page).to have_content "投稿日: #{date.strftime("%Y年 %m月 %d日 %H時 %M分")}"
        expect(page).to have_content '投稿者: hoge'
        expect(page).to have_content 'いいね件数: 1'
        expect(page).to have_content '店名: hoge'
        expect(page).to have_content 'レビュー: fuga_review'
      end
    end

    context 'to search by store name' do 
      it 'search and display by store name' do 
        fill_in 'search-words', with: 'test'
        click_on '検索'
        expect(page).to have_content '店名: test'
        expect(page).to have_content 'レビュー: hoge_review'
      end
    end

    context 'to search by review' do 
      it 'search and display by review' do 
        fill_in 'search-words', with: 'fuga_review'
        click_on '検索'
        expect(page).to have_content '店名: hoge'
        expect(page).to have_content 'レビュー: fuga_review'
      end
    end

    context 'to search by store name and reviews' do 
      it 'show the matches for each condition.' do 
        fill_in 'search-words', with: 'hoge'
        click_on '検索'
        expect(page).to have_content '店名: test'
        expect(page).to have_content 'レビュー: hoge_review'
        expect(page).to have_content '店名: hoge'
        expect(page).to have_content 'レビュー: fuga_review'
      end
    end
  end
end

