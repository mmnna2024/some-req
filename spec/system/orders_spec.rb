require "rails_helper"

RSpec.describe "Orders", type: :system do
  let!(:admin) { FactoryBot.create(:admin) }
  let!(:category1) { FactoryBot.create(:category1) }
  let!(:category2) { FactoryBot.create(:category2) }
  let!(:category3) { FactoryBot.create(:category3) }
  let!(:customer1) { FactoryBot.create(:customer1) }
  let!(:customer2) { FactoryBot.create(:customer2) }
  let!(:customer3) { FactoryBot.create(:customer3) }
  let!(:customer4) { FactoryBot.create(:customer4) }
  let!(:shipping) { FactoryBot.create(:shipping1) }
  let!(:order1) { FactoryBot.create(:order1, customer: customer1, shipping: shipping) }
  let!(:order2) { FactoryBot.create(:order2, customer: customer2, shipping: shipping) }
  let!(:order3) { FactoryBot.create(:order3, customer: customer3, shipping: shipping) }
  let!(:order4) { FactoryBot.create(:order4, customer: customer4, shipping: shipping) }
  let!(:item1) { FactoryBot.create(:item1, category: category1, order: order1) }
  let!(:item2) { FactoryBot.create(:item2, category: category2, order: order2) }
  let!(:item3) { FactoryBot.create(:item3, category: category3, order: order3) }
  let!(:item4) { FactoryBot.create(:item4, category: category1, order: order4) }

  before do
    visit new_admin_session_path
    fill_in "admin[user_id]", with: admin.user_id
    fill_in "admin[password]", with: admin.password
    find("#login").click
  end

  describe "仮受注一覧表示ページ" do
    it "ステータスが仮受注の受注一覧が表示される" do
      visit unchecked_index_admin_orders_path
      expect(page).to have_content "customer1"
      expect(page).to have_content "customer2"
    end
    it "受注を削除できる" do
      visit unchecked_index_admin_orders_path
      all("tbody tr")[0].click_link "削除"
      expect(page.accept_confirm).to eq "本当に削除しますか？"
      expect(page).to have_content "customer1"
    end
    it "受注詳細ページに遷移できる" do
      visit unchecked_index_admin_orders_path
      all("tbody tr")[1].click_link "詳細"
      expect(page).to have_content "受注詳細・編集ページ"
    end
    it "受注日時で昇順・降順にソートできる" do
      visit unchecked_index_admin_orders_path
    end
  end

  describe "受注済み一覧表示ページ" do
    it "ステータスが受注済みの受注一覧が表示される" do
      visit checked_index_admin_orders_path
      expect(page).to have_content "customer3"
      expect(page).to have_content "customer4"
    end
    it "受注を削除できる" do
      visit checked_index_admin_orders_path
      all("tbody tr")[0].click_link "削除"
      expect(page.accept_confirm).to eq "本当に削除しますか？"
      expect(page).to have_content "customer4"
    end
    it "受注詳細ページに遷移できる" do
      visit checked_index_admin_orders_path
      all("tbody tr")[1].click_link "詳細"
      expect(page).to have_content "受注詳細・編集ページ"
    end
    it "受注日時で昇順・降順にソートできる" do
      visit checked_index_admin_orders_path
    end
  end

  describe "受注詳細・編集ページ" do
    it "受注を編集できる" do
      visit edit_admin_order_path(order1)
      select "Tシャツ", from: "order_form[category_ids][]"
      fill_in "料金", with: 2750
      fill_in "備考", with: "テスト"
      fill_in "名前", with: "customer1"
      fill_in "電話番号", with: "012-3456-7890"
      fill_in "メールアドレス", with: "customer1@test.com"
      fill_in "住所", with: "静岡県静岡市"
      fill_in "年齢", with: 25
      select "male", from: "性別"
      choose "店頭受付"
      select "unchecked_order", from: "受注ステータス"
      find("#update-order").click
      expect(page).to have_content "仮受注一覧"
    end
  end
end
