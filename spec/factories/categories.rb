FactoryBot.define do
  factory :category1, class: Category do
    name { "Tシャツ" }
    price { 2750 }
    display { true }
  end

  factory :category2, class: Category do
    name { "ワンピース" }
    price { 2750 }
    display { true }
  end

  factory :category3, class: Category do
    name { "デニムパンツ" }
    price { 3300 }
    display { false }
  end

  factory :category4, class: Category do
    name { "パーカー" }
    price { 3300 }
  end
end