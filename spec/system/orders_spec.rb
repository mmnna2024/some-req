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
    fill_in "ユーザーID", with: admin.user_id
    fill_in "パスワード", with: admin.password
    click_on "ログイン"
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
      expect(page).to have_content "受注詳細・編集"
    end
    it "受注日時で昇順・降順にソートできる" do
      visit unchecked_index_admin_orders_path
      click_on "受注日時"
      sleep 0.5
      within all("tbody tr")[0] do
        expect(page).to have_content "customer1"
      end
      within all("tbody tr")[1] do
        expect(page).to have_content "customer2"
      end
      find('#sort_by_ordered_on').click
      sleep 0.5
      within all("tbody tr")[0] do
        expect(page).to have_content "customer2"
      end
      within all("tbody tr")[1] do
        expect(page).to have_content "customer1"
      end
    end

    context "検索機能" do
      it "名前であいまい検索をした場合、検索ワードを含む受注が表示される" do
        customer1.update!(name: "山田太郎")
        customer2.update!(name: "佐藤次郎")
        visit unchecked_index_admin_orders_path
        fill_in "名前", with: "山田"
        click_on "検索"
        expect(page).to have_content "山田太郎"
        expect(page).not_to have_content "佐藤次郎"
      end
      it "電話番号で検索をした場合、検索ワードを含む受注が表示される" do
        visit unchecked_index_admin_orders_path
        fill_in "電話番号", with: "987-666-7777"
        click_on "検索"
        expect(page).to have_content "customer2"
        expect(page).not_to have_content "customer1"
      end
      it "受注日時で検索をした場合、選択した期間に受けた受注が表示される" do
        visit unchecked_index_admin_orders_path
        fill_in "q_ordered_on_gteq", with: "002024-04-21"
        fill_in "q_ordered_on_lteq", with: "002024-04-24"
        click_on "検索"
        expect(page).to have_content "customer1"
        expect(page).not_to have_content "customer2"
      end
    end
  end

  describe "受注済み一覧表示ページ" do

    before do
      visit checked_index_admin_orders_path
    end

    it "ステータスが受注済みの受注一覧が表示される" do
      expect(page).to have_content "customer3"
      expect(page).to have_content "customer4"
    end
    it "受注を削除できる" do
      all("tbody tr")[0].click_link "削除"
      expect(page.accept_confirm).to eq "本当に削除しますか？"
      expect(page).to have_content "customer4"
    end
    it "受注詳細ページに遷移できる" do
      all("tbody tr")[1].click_link "詳細"
      expect(page).to have_content "受注詳細・編集"
    end
    it "受注日時で昇順・降順にソートできる" do
      find('#sort_by_ordered_on').click
      sleep 0.5
      within all("tbody tr")[0] do
        expect(page).to have_content "customer4"
      end
      within all("tbody tr")[1] do
        expect(page).to have_content "customer3"
      end
      find('#sort_by_ordered_on').click
      sleep 0.5
      within all("tbody tr")[0] do
        expect(page).to have_content "customer3"
      end
      within all("tbody tr")[1] do
        expect(page).to have_content "customer4"
      end
    end

    context "検索機能" do
      it "名前であいまい検索をした場合、検索ワードを含む受注が表示される" do
        customer3.update!(name: "山田太郎")
        customer4.update!(name: "佐藤次郎")
        fill_in "名前", with: "山田"
        click_on "検索"
        expect(page).to have_content "山田太郎"
        expect(page).not_to have_content "佐藤次郎"
      end
      it "電話番号で検索をした場合、検索ワードを含む受注が表示される" do
        fill_in "電話番号", with: "777-666-5555"
        click_on "検索"
        expect(page).to have_content "customer4"
        expect(page).not_to have_content "customer3"
      end
      it "受注日時で検索をした場合、選択した期間に受けた受注が表示される" do
        fill_in "q_ordered_on_gteq", with: "002024-04-18"
        fill_in "q_ordered_on_lteq", with: "002024-04-19"
        click_on "検索"
        expect(page).to have_content "customer3"
        expect(page).not_to have_content "customer4"
      end
    end
  end

  describe "受注詳細・編集ページ" do
    it "受注を編集できる" do
      visit edit_admin_order_path(order1)
      select "Tシャツ", from: "依頼品"
      fill_in "料金", with: 2750
      fill_in "order_form_note", with: "テスト"
      fill_in "名前", with: "customer1"
      fill_in "住所", with: "静岡県静岡市"
      select "関東・南東北・信越・北陸・中部", from: "地域区分"
      fill_in "電話番号", with: "012-3456-7890"
      fill_in "メールアドレス", with: "customer1@test.com"
      fill_in "年齢", with: 25
      select "男性", from: "性別"
      select "オンライン受付", from: "受付窓口"
      choose "仮受注"
      click_on "更新する"
      expect(page).to have_content "更新しました"
      expect(page).to have_content "仮受注一覧"
    end
  end
end
