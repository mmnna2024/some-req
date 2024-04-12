FactoryBot.define do
  factory :order_form do
    category_ids { [] }
    note { "テスト注文" }
    name { "テスト名前" }
    phonenumber { '000-0000-0000' }
    email { "test@example.com" }
    address { 'テスト住所' }
    age { 30 }
    sex { 0 }
    shipping_id { nil }
    channel { 1 }
    status { 0 }
  end
end