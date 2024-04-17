require "rails_helper"

RSpec.describe "Categories", type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:category1) { FactoryBot.create(:category1, created_at: "2024/04/17") }
  let!(:category2) { FactoryBot.create(:category2, created_at: "2024/04/16") }
  let!(:category3) { FactoryBot.create(:category3, created_at: "2024/04/15") }
  let!(:category4) { FactoryBot.create(:category4, created_at: "2024/04/14") }
  let!(:customer) { FactoryBot.create(:customer1) }
  let!(:shipping) { FactoryBot.create(:shipping1) }
  let!(:order) { FactoryBot.create(:order1, customer: customer, shipping: shipping) }
  let!(:item) { FactoryBot.create(:item1, category: category1, order: order) }

  before do
    visit new_admin_session_path
    fill_in "ユーザーID", with: admin.user_id
    fill_in "パスワード", with: admin.password
    click_on 'ログイン'
  end

  describe "カテゴリー一覧ページ" do
    context "一覧ページに遷移した場合" do
      it "作成済みのカテゴリー一覧が表示される" do
        visit admin_categories_path
        expect(page).to have_content "Tシャツ"
        expect(page).to have_content "ワンピース"
        expect(page).to have_content "デニムパンツ"
      end
      it "公開設定をONにできる" do
        visit admin_categories_path
        all('tbody tr')[2].click_on '非公開'
        expect(page.accept_confirm).to eq "公開設定を変更してよろしいですか？"
        sleep 0.5
        within all('tbody tr')[2], js: true do
          expect(page).to have_content '公開中'
        end
      end
      it "公開設定をOFFにできる" do
        visit admin_categories_path
        all('tbody tr')[0].click_on '公開中'
        expect(page.accept_confirm).to eq "公開設定を変更してよろしいですか？"
        sleep 0.5
        within all('tbody tr')[2], js: true do
          expect(page).to have_content '非公開'
        end
      end
      it "カテゴリーを削除できる" do
        visit admin_categories_path
        all("tbody tr")[2].click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "Tシャツ"
        expect(page).to have_content "ワンピース"
      end
      it "公開中のメニューが上になるかつ作成日時の降順で並んでいる" do
        visit admin_categories_path
        within all('tbody tr')[0] do
          expect(page).to have_content "Tシャツ"
        end
        within all('tbody tr')[1] do
          expect(page).to have_content "ワンピース"
        end
        within all('tbody tr')[2] do
          expect(page).to have_content "デニムパンツ"
        end
        within all('tbody tr')[3] do
          expect(page).to have_content "パーカー"
        end
      end
    end

    context "カテゴリーが1つ以上の依頼品との関連がある場合" do
      it "「依頼品と紐づいているため削除できません」とメッセージが表示される" do
        visit admin_categories_path
        all("tbody tr")[0].click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "依頼品に紐づいているため削除できません"
      end
    end
  end

  describe "カテゴリー追加ページ" do
    it "カテゴリーを追加できる" do
      visit new_admin_category_path
      fill_in "メニュー名", with: "帽子"
      fill_in "料金", with: 4400
      click_on "追加する"
      expect(page).to have_content "カテゴリーを追加しました"
      expect(page).to have_content "帽子"
    end
  end
end
