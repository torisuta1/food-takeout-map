require "rails_helper"

RSpec.describe "new_post_page" do
  before do
    visit root_path
    click_link "ゲストログイン（閲覧用）"
    visit new_post_path
  end

  context "store name" do
    it "existing 店名" do
      expect(page).to have_content "店名(必須)"
    end
  end

  context "review" do
    it "existing レビュー" do
      expect(page).to have_content "レビュー"
    end
  end

  context "image" do
    it "existing 画像" do
      expect(page).to have_content "画像"
    end
  end

  context "genre" do
    it "existing 価格帯" do
      expect(page).to have_content "価格帯(必須）"
    end
  end

  context "post button" do
    it "existing 投稿" do
      expect(page).to have_button "投稿"
    end
  end
end
