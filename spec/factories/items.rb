FactoryBot.define do
  factory :item1, class: Item do
    price { 2750 }
    association :order
    association :category
  end

  factory :item2, class: Item do
    price { 2750 }
    association :order
    association :category
  end

  factory :item3, class: Item do
    price { 2750 }
    association :order
    association :category
  end

  factory :item4, class: Item do
    price { 3300 }
    association :order
    association :category
  end
end