require "rails_helper"

RSpec.describe "sign_up_page" do
  before do
    visit new_user_registration_path
  end

  context "sign_up" do
    it "existing SIGN UP" do
      expect(page).to have_selector "h2", text: "サインアップ"
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
      expect(page).to have_content "パスワード (6文字以上)"
    end
  end

  context "password confirmation" do
    it "existing Password confirmation" do
      expect(page).to have_content "確認用パスワード"
    end
  end

  context "check_box" do
    it "existing check_box" do
      expect(page).to have_field ("")
    end
  end

  context "agree with the text" do
    it "existing agree with the text" do
      expect(page).to have_content "利用規約と プライバシーポリシーに同意する"
    end
  end

  context "sign_up_button" do
    it "existing Sign_up button" do
      expect(page).to have_button "サインアップ"
    end
  end

  context "log_in" do
    it "existing log_in link" do
      expect(page).to have_link "ログイン"
    end
  end

  context "authentication email" do
    it "existing 認証メールが届かない場合" do
      expect(page).to have_link "認証メールが届かない場合"
    end
  end
end
