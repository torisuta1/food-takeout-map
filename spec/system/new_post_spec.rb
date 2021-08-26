require "rails_helper"

RSpec.describe "New_post_page", type: :system do
  describe "submission process" do
    let!(:genre) { create(:genre) }

    before do
      visit root_path
      click_link "ゲストログイン（閲覧用）"
      visit new_post_path
    end

    context "for normal input" do
      it "successful submission" do
        fill_in "new-store-name", with: "test"
        fill_in "new-review", with: "test"
        attach_file "new-post-image", "app/assets/images/4036048_m.jpg"
        select "~1500円", from: "価格帯(必須）"
        click_on "投稿"
        expect(page).to have_content "投稿が完了しました"
      end
    end

    context "store name not into the force" do
      it "submission fails" do
        fill_in "new-store-name", with: ""
        fill_in "new-review", with: "test"
        select "~1500円", from: "価格帯(必須）"
        click_on "投稿"
        expect(page).to have_content "投稿に失敗しました"
      end
    end

    context "review not into the force" do
      it "successful submission" do
        fill_in "new-store-name", with: "test"
        fill_in "new-review", with: ""
        select "~1500円", from: "価格帯(必須）"
        click_on "投稿"
        expect(page).to have_content "投稿が完了しました"
      end
    end

    context "posting an image" do
      it "processed normally" do
        fill_in "new-store-name", with: "test"
        fill_in "new-review", with: "test"
        select "~1500円", from: "価格帯(必須）"
        attach_file "new-post-image", "app/assets/images/4036048_m.jpg"
        click_on "投稿"
        expect(page).to have_content "投稿が完了しました"
        visit posts_path
        expect(page).to have_selector("img[src$='4036048_m.jpg']")
      end
    end

    context "genre not into the force" do
      it "submission fails" do
        fill_in "new-store-name", with: "test"
        fill_in "new-review", with: "test"
        click_on "投稿"
        expect(page).to have_content "投稿に失敗しました"
      end
    end
  end
end
