require "rails_helper"

RSpec.describe Category, type: :model do
  let!(:category1) { FactoryBot.create(:category1) }
  let!(:category2) { FactoryBot.create(:category2) }
  let!(:category3) { FactoryBot.create(:category3) }
  let!(:category4) { FactoryBot.create(:category4) }
  let!(:customer) { FactoryBot.create(:customer1) }
  let!(:shipping) { FactoryBot.create(:shipping1) }
  let!(:order) { FactoryBot.create(:order1, customer: customer, shipping: shipping) }
  let!(:item) { FactoryBot.create(:item1, category: category1, order: order)}

  describe "バリデーションのテスト" do
    it "カテゴリー名が空欄の場合、バリデーションに失敗する" do
      category1.update(name: nil)
      expect(category1).to be_invalid
      expect(category1.errors.full_messages).to eq ["メニュー名を入力してください。"]
    end

    it "料金が空欄の場合、バリデーションに失敗する" do
      category1.update(price: nil)
      expect(category1).to be_invalid
      expect(category1.errors.full_messages).to eq ["料金を入力してください。"]
    end

    it "カテゴリー名が同じ場合、バリデーションに失敗する" do
      category1.update(name: "ワンピース")
      expect(category1).to be_invalid
      expect(category1.errors.full_messages).to eq ["メニュー名はすでに存在します。"]
    end
  end

  describe "コールバックのテスト" do
    it "カテゴリーが1つ以上の依頼品との関連がある場合、削除できない" do
      expect(category1.destroy).to be(false)
      expect(Category.exists?(category1.id)).to be(true)
    end

    it "カテゴリーが依頼品との関連がない場合、削除できる" do
      category2.destroy
      expect(Category.exists?(category2.id)).to be(false)
    end
  end
end
