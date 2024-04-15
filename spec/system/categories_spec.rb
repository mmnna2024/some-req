require "rails_helper"

RSpec.describe "Categories", type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:category1) { FactoryBot.create(:category1) }
  let!(:category2) { FactoryBot.create(:category2) }
  let!(:category3) { FactoryBot.create(:category3) }
  let!(:customer) { FactoryBot.create(:customer1) }
  let!(:shipping) { FactoryBot.create(:shipping1) }
  let!(:order) { FactoryBot.create(:order1, customer: customer, shipping: shipping) }
  let!(:item) { FactoryBot.create(:item1, category: category1, order: order) }

  before do
    visit new_admin_session_path
    fill_in "admin[user_id]", with: admin.user_id
    fill_in "admin[password]", with: admin.password
    find("#login").click
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
        find("input[type='checkbox'][value='#{category3.id}']").set(true)
        find("#update-categories").click
        find("input[type='checkbox'][value='#{category3.id}']").checked?
      end
      it "公開設定をOFFにできる" do
        visit admin_categories_path
        find("input[type='checkbox'][value='#{category1.id}']").set(false)
        find("#update-categories").click
        find("input[type='checkbox'][value='#{category1.id}']").disabled?
      end
      it "カテゴリーを削除できる" do
        visit admin_categories_path
        all("tbody tr")[2].click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "Tシャツ"
        expect(page).to have_content "ワンピース"
      end
      it "メニュー追加ページに遷移できる" do
        visit admin_categories_path
        find("#new_category_link").click
        expect(page).to have_content "メニュー追加"
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
      fill_in "category[name]", with: "コート"
      fill_in "category[price]", with: 4400
      find("#add-category").click
      expect(page).to have_content "コート"
    end
    it "メニュー一覧ページに遷移できる" do
      visit new_admin_category_path
      find("#categories_link").click
      expect(page).to have_content "メニュー管理"
    end
  end
end
