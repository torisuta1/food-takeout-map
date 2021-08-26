require "rails_helper"

RSpec.describe "my_page" do
  let(:user) { create(:user, email: "test@example.com") }

  before do
    user.confirm
    visit new_user_session_path
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    click_on "ユーザー編集"
  end

  context "edit_user" do
    it "existing edit user" do
      expect(page).to have_selector "h2", text: "ユーザー編集"
    end
  end

  context "user_name" do
    it "existing Username" do
      expect(page).to have_content "ユーザーネーム"
    end
  end

  context "email" do
    it "existing Email" do
      expect(page).to have_content "メールアドレス"
    end
  end

  context "password" do
    it "existing Password" do
      expect(page).to have_content "パスワード (変更希望がなければ空欄でも可能です)"
    end
  end

  context "password confirmation" do
    it "existing Password confirmation" do
      expect(page).to have_content "確認用パスワード"
    end
  end

  context "current password" do
    it "existing current Password" do
      expect(page).to have_content "現在のパスワード (変更を反映するには必要です)"
    end
  end

  context "profile" do
    it "existing profile" do
      expect(page).to have_content "プロフィール"
    end
  end

  context "sign_up_button" do
    it "existing update button" do
      expect(page).to have_button "更新"
    end
  end

  context "cancel_account" do
    it "existing cancel account" do
      expect(page).to have_selector "h3", text: "アカウント削除"
    end
  end

  context "cancel_account_button" do
    it "existing cancel button" do
      expect(page).to have_button "アカウント削除"
    end
  end
end
