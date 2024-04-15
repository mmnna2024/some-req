require "rails_helper"

RSpec.describe "Admins", type: :system do
  let!(:admin) { FactoryBot.create(:admin) }

  describe "ログイン機能" do
    context "登録済みの管理者でログインした場合" do
      it "仮受注一覧ページに遷移し、ログインが成功したメッセージが表示される" do
        visit new_admin_session_path
        fill_in "admin[user_id]", with: admin.user_id
        fill_in "admin[password]", with: admin.password
        find("#login").click
        expect(page).to have_content("仮受注一覧")
        expect(page).to have_content("Signed in successfully.")
      end
    end

    context "ログインに失敗した場合" do
      it "ログインページに再度遷移し、ユーザーIDかパスワードが間違っているメッセージが表示される" do
        visit new_admin_session_path
        fill_in "admin[user_id]", with: "Noadmin"
        fill_in "admin[password]", with: "0a2b3c"
        find("#login").click
        expect(page).to have_selector '#login-title'
        expect(page).to have_content("Invalid User or password.")
      end
    end
  end

  describe "ログアウト機能" do
    before do
      visit new_admin_session_path
      fill_in "admin[user_id]", with: admin.user_id
      fill_in "admin[password]", with: admin.password
      find("#login").click
    end

    context "登録済みの管理者でログインした場合" do
      it "仮受注一覧ページに遷移し、ログインが成功したメッセージが表示される" do
        click_on 'ログアウト'
        expect(page.accept_confirm).to eq "本当にログアウトしますか？"
        expect(page).to have_selector '#login-title'
        expect(page).to have_content("Signed out successfully.")
      end
    end
  end
end
