require "rails_helper"

RSpec.describe Category, type: :model do
  let!(:category1) { FactoryBot.create(:category1) }
  let!(:category2) { FactoryBot.create(:category2) }
  let!(:category3) { FactoryBot.create(:category3) }
  let!(:category4) { FactoryBot.create(:category4) }
  # let!(:customer1) { FactoryBot.create(:customer1) }
  # let!(:customer2) { FactoryBot.create(:customer2) }
  # let!(:customer3) { FactoryBot.create(:customer3) }
  # let!(:shipping1) { FactoryBot.create(:shipping1) }
  # let!(:shipping2) { FactoryBot.create(:shipping2) }
  # let!(:shipping3) { FactoryBot.create(:shipping3) }
  # let!(:order1) { FactoryBot.create(:order1, customer: customer1, shipping: shipping1) }
  # let!(:order2) { FactoryBot.create(:order2, customer: customer2, shipping: shipping2) }
  # let!(:order3) { FactoryBot.create(:order3, customer: customer3, shipping: shipping3) }
  # let!(:item1) { FactoryBot.create(:item1, category: category1) }
  # let!(:item2) { FactoryBot.create(:item2, category: category2, order: order1) }
  # let!(:item3) { FactoryBot.create(:item3, category: category1, order: order2) }
  # let!(:item4) { FactoryBot.create(:item4, category: category3, order: order2) }
  # let!(:item5) { FactoryBot.create(:item5, category: category2, order: order3) }
  # let!(:item6) { FactoryBot.create(:item6, category: category3, order: order3) }

  describe "バリデーションのテスト" do
    it "カテゴリー名が空欄の場合、バリデーションに失敗する" do
      category1.update(name: nil)
      expect(category1).to be_invalid
      expect(category1.errors.full_messages).to eq ["Name can't be blank"]
    end

    it "料金が空欄の場合、バリデーションに失敗する" do
      category1.update(price: nil)
      expect(category1).to be_invalid
      expect(category1.errors.full_messages).to eq ["Price can't be blank"]
    end

    it "カテゴリー名が同じ場合、バリデーションに失敗する" do
      category1.update(name: "ワンピース")
      expect(category1).to be_invalid
      expect(category1.errors.full_messages).to eq ["Name has already been taken"]
    end
  end
end
