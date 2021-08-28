require "rails_helper"

RSpec.describe "Search", type: :system do
  let!(:post) { create(:post) }

  describe "when not logged in" do
    before do
      visit posts_path
    end

    it "the like button is not displayed" do
      expect(page).to_not have_button "like-button"
    end
  end

  describe "when logged in" do
    before do
      visit root_path
      click_on "ゲストログイン（閲覧用）"
      visit posts_path
    end

    it "the like button is displayed" do
      expect(page).to have_button "like-button"
    end
  end
end
