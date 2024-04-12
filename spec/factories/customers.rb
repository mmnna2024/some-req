FactoryBot.define do
  factory :customer1, class: Customer do
    name { "cutomer1" }
    email { "customer1@test.com" }
    phonenumber { "012-333-5555" }
    address { "東京都新宿区" }
    sex { 0 }
    age { 26 }
  end

  factory :customer2, class: Customer do
    name { "cutomer2" }
    email { "customer2@test.com" }
    phonenumber { "987-666-7777" }
    address { "鹿児島県鹿児島市" }
    sex { 1 }
    age { 33 }
  end

  factory :customer3, class: Customer do
    name { "cutomer3" }
    email { "customer3@test.com" }
    phonenumber { "765-555-6666" }
    address { "山梨県富士吉田市" }
    sex { 0 }
    age { 24 }
  end
end