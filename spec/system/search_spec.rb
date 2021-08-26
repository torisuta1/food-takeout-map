require "rails_helper"

RSpec.describe "Search", type: :system do
  let!(:post) { create(:post) }
  let!(:post2) { create(:post2) }

  describe "When not logged in" do
    before do
      visit search_posts_path
    end

    context "if no input" do
      it "view all posts" do
        click_on "検索"
        expect(page).to have_content "検索条件が指定されていません、全投稿を表示します。"
        expect(page).to have_content "店名: test"
        expect(page).to have_content "レビュー: hoge_review"
        date = DateTime.now
        expect(page).to have_content "投稿日: #{date.strftime("%Y年 %m月 %d日 %H時 %M分")}"
        expect(page).to have_content "投稿者: hoge"
        expect(page).to have_content "いいね件数: 1"
        expect(page).to have_content "店名: hoge"
        expect(page).to have_content "レビュー: fuga_review"
      end
    end

    context "to search by store name" do
      it "search and display by store name" do
        fill_in "search-words", with: "test"
        click_on "検索"
        expect(page).to have_content "店名: test"
        expect(page).to have_content "レビュー: hoge_review"
      end
    end

    context "to search by review" do
      it "search and display by review" do
        fill_in "search-words", with: "fuga_review"
        click_on "検索"
        expect(page).to have_content "店名: hoge"
        expect(page).to have_content "レビュー: fuga_review"
      end
    end

    context "to search by store name and reviews" do
      it "show the matches for each condition" do
        fill_in "search-words", with: "hoge"
        click_on "検索"
        expect(page).to have_content "店名: test"
        expect(page).to have_content "レビュー: hoge_review"
        expect(page).to have_content "店名: hoge"
        expect(page).to have_content "レビュー: fuga_review"
      end
    end

    context "to search by price range" do
      it "show less than 1500 yen" do
        select "~1500円", from: "genre-select"
        click_on "検索"
        expect(page).to have_content "店名: test"
        expect(page).to have_content "レビュー: hoge_review"
      end
    end

    context "to search by price range" do
      it "show more than 1500 yen" do
        select "1500円~", from: "genre-select"
        click_on "検索"
        expect(page).to have_content "店名: hoge"
        expect(page).to have_content "レビュー: fuga_review"
      end
    end

    context "to search by search term and price range" do
      it "show the matches for each condition" do
        fill_in "search-words", with: "test"
        select "1500円~", from: "genre-select"
        click_on "検索"
        expect(page).to have_content "店名: test"
        expect(page).to have_content "レビュー: hoge_review"
        expect(page).to have_content "店名: hoge"
        expect(page).to have_content "レビュー: fuga_review"
      end
    end

    context "like function" do
      it "works fine" do
        click_on "検索"
        expect(page).to have_content "いいね件数: 1"
        expect(page).to have_content "いいね件数: 0"
      end
    end

    context "link to contributors" do
      it "works fine" do
        fill_in "search-words", with: "test"
        click_on "検索"
        expect(page).to have_link "hoge"
        click_link "hoge"
        expect(page).to have_content "ユーザー詳細"
      end
    end
  end

  describe "When logged in" do
    before do
      visit root_path
      click_on "ゲストログイン（閲覧用）"
      visit search_posts_path
    end

    context "like button" do
      it "view all posts" do
        fill_in "search-words", with: "test"
        click_on "検索"
        find(".like-button").click
        expect(page).to have_content "いいね件数: 2"
        find(".like-button").click
        expect(page).to have_content "いいね件数: 1"
      end
    end
  end
end
