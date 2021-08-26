require "rails_helper"

RSpec.describe "home_page" do
  before do
    visit root_path
  end

  context "sign_up" do
    it "existing サインアップ" do
      expect(page).to have_selector "li", text: "サインアップ"
    end
  end

  context "log_in" do
    it "existing ログイン" do
      expect(page).to have_selector "li", text: "ログイン"
    end
  end

  context "search" do
    it "existing 検索" do
      expect(page).to have_selector "li", text: "検索"
    end
  end

  context "view" do
    it "existing 一覧" do
      expect(page).to have_selector "li", text: "一覧"
    end
  end

  context "guest_log_in" do
    it "existing ゲストログイン" do
      expect(page).to have_selector "li", text: "ゲストログイン（閲覧用）"
    end
  end

  context "post" do
    it "existing 投稿する" do
      expect(page).to have_selector "li", text: "投稿する"
    end
  end

  context "terms_of_use" do
    it "existing 利用規約" do
      expect(page).to have_content "利用規約"
    end
  end

  context "privacy_policy" do
    it "existing プライバシーポリシー" do
      expect(page).to have_content "プライバシーポリシー"
    end
  end

  context "home" do
    it "existing ホーム" do
      expect(page).to have_selector "li", text: "ホーム"
    end
  end

  context "log_out" do
    it "not existing ログアウト" do
      expect(page).to_not have_selector "li", text: "ログアウト"
    end
  end

  context "my_page" do
    it "not existing マイページ" do
      expect(page).to_not have_selector "li", text: "マイページ"
    end
  end

  context "my_posts" do
    it "not existing マイ投稿" do
      expect(page).to_not have_selector "li", text: "マイ投稿"
    end
  end

  context "user_edit" do
    it "not existing ユーザー編集" do
      expect(page).to_not have_selector "li", text: "ユーザー編集"
    end
  end
end
