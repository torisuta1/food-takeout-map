require "rails_helper"

RSpec.describe "reset_password_page" do
  before do
    visit new_user_password_path
  end

  context "reset_password" do
    it "existing forgot your password?" do
      expect(page).to have_selector "h2", text: "パスワードを忘れた場合"
    end
  end

  context "email" do
    it "existing email" do
      expect(page).to have_content "メールアドレス"
    end
  end

  context "send_button" do
    it "existing send_button" do
      expect(page).to have_button "パスワードリセットメールを送信"
    end
  end

  context "log_in_link" do
    it "existing log_inn_link" do
      expect(page).to have_link "ログイン"
    end
  end

  context "sign_up_link" do
    it "existing sign_up_link" do
      expect(page).to have_link "サインアップ"
    end
  end

  context "Authentication email" do
    it "existing 認証メールが届かない場合" do
      expect(page).to have_link "認証メールが届かない場合"
    end
  end
end
