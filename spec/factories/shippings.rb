FactoryBot.define do
  factory :shipping1, class: Shipping do
    name { "関東・南東北・信越・北陸・中部" }
    price { 1500 }
  end

  factory :shipping2, class: Shipping do
    name { "北東北・関西" }
    price { 1700 }
  end

  factory :shipping3, class: Shipping do
    name { "北海道・九州" }
    price { 2000 }
  end
end