FactoryBot.define do
  factory :order1, class: Order do
    ordered_on { DateTime.now + 5.days }
    price { 2750 }
    status { 0 }
    channel { 0 }
    note { "テスト" }
    association :customer
  end

  factory :order2, class: Order do
    ordered_on { DateTime.now + 3.days }
    price { 2750 }
    status { 0 }
    channel { 0 }
    note { "テスト" }
    association :customer
  end

  factory :order3, class: Order do
    ordered_on { DateTime.now + 1.days }
    price { 2750 }
    status { 1 }
    channel { 0 }
    note { "テスト" }
    association :customer
  end

  factory :order4, class: Order do
    ordered_on { DateTime.now }
    price { 2750 }
    status { 1 }
    channel { 0 }
    note { "テスト" }
    association :customer
  end
end