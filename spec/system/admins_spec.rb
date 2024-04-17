require "rails_helper"

RSpec.describe "Admins", type: :system do
  let!(:admin) { FactoryBot.create(:admin) }

  describe "ログイン機能" do
    context "登録済みの管理者でログインした場合" do
      it "仮受注一覧ページに遷移し、ログインが成功したメッセージが表示される" do
        visit new_admin_session_path
        fill_in "ユーザーID", with: admin.user_id
        fill_in "パスワード", with: admin.password
        click_on 'ログイン'
        expect(page).to have_content("仮受注一覧")
        expect(page).to have_content("ログインしました")
      end
    end

    context "ログインに失敗した場合" do
      it "ログインページに再度遷移し、ユーザーIDかパスワードが間違っているメッセージが表示される" do
        visit new_admin_session_path
        fill_in "ユーザーID", with: "Noadmin"
        fill_in "パスワード", with: "0a2b3c"
        click_on 'ログイン'
        expect(page).to have_content("ログインページ")
        expect(page).to have_content("ユーザーIDまたはパスワードが違います。")
      end
    end
  end

  describe "ログアウト機能" do
    before do
      visit new_admin_session_path
      fill_in "ユーザーID", with: admin.user_id
      fill_in "パスワード", with: admin.password
      click_on 'ログイン'
    end

    context "ログアウトした場合" do
      it "確認のダイアログが表示された後、ログインページに遷移し、ログアウトに成功したメッセージが表示される" do
        click_on 'ログアウト'
        expect(page.accept_confirm).to eq "本当にログアウトしますか？"
        expect(page).to have_content("ログインページ")
        expect(page).to have_content("ログアウトしました")
      end
    end
  end
end
