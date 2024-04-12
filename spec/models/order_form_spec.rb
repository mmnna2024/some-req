require "rails_helper"

RSpec.describe OrderForm, type: :model do
  let!(:customer) { FactoryBot.create(:customer1) }
  let!(:shipping) { FactoryBot.create(:shipping1) }
  let!(:category1) { FactoryBot.create(:category1) }
  let!(:order) { FactoryBot.create(:order1, customer: customer, shipping: shipping) }
  let!(:item) { FactoryBot.create(:item1, order: order, category: category1) }

  let(:order_form) { FactoryBot.build(:order_form, category_ids: [category1.id], shipping_id: shipping.id) }

  before do
    order_form.name = customer.name
    order_form.phonenumber = customer.phonenumber
    order_form.email = customer.email
    order_form.address = customer.address
    order_form.age = customer.age
    order_form.sex = customer.sex
    order_form.items = [item]
  end

  describe "受注フォームのバリデーション" do
    context "内容に問題ない場合" do
      it "すべての値が正しく入力されていれば注文できる" do
        expect(order_form).to be_valid
      end

      it "備考が空でも注文できる" do
        order_form.note = ""
        expect(order_form).to be_valid
      end

      it "年齢が空でも注文できる" do
        order_form.age = ""
        expect(order_form).to be_valid
      end

      it "性別が空でも注文できる" do
        order_form.sex = ""
        expect(order_form).to be_valid
      end

      it "受付チャネルが空でも注文できる" do
        order_form.channel = ""
        expect(order_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '依頼品の金額が空の場合保存できない' do
        item.price = nil
        order_form.valid?
        expect(order_form.errors.full_messages).to include("Items Price can't be blank")
      end

      it '依頼者の名前が空の場合保存できない' do
        order_form.name = ""
        order_form.valid?
        expect(order_form.errors.full_messages).to include("Name can't be blank")
      end

      it '依頼者の電話番号が空の場合保存できない' do
        order_form.phonenumber = ""
        order_form.valid?
        expect(order_form.errors.full_messages).to include("Phonenumber can't be blank")
      end

      it '依頼者のメールアドレスが空の場合保存できない' do
        order_form.email = ""
        order_form.valid?
        expect(order_form.errors.full_messages).to include("Email can't be blank")
      end

      it '依頼者の住所が空の場合保存できない' do
        order_form.address = ""
        order_form.valid?
        expect(order_form.errors.full_messages).to include("Address can't be blank")
      end
    end
  end
end
