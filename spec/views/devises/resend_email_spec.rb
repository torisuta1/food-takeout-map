require "rails_helper"

RSpec.describe "resend_email_page" do
  let!(:user) { create(:user) }

  before do
    visit user_confirmation_path
  end

  context "resend email" do
    it "existing resend confirmation instructions" do
      expect(page).to have_selector "h2", text: "認証メール再送"
    end
  end

  context "email" do
    it "existing email" do
      expect(page).to have_content "メールアドレス"
    end
  end

  context "resend button" do
    it "existing resend button" do
      expect(page).to have_button "認証メール再送"
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

  context "password_link" do
    it "existing Forgot your password?" do
      expect(page).to have_link "パスワードを忘れた場合"
    end
  end
end
