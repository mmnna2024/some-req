FactoryBot.define do
  factory :order1, class: Order do
    ordered_on { DateTime.now + 5.days }
    price { 2750 }
    status { 0 }
    channel { 0 }
    note { "綿98%ですが黒染めできますか？" }
    customer
    shipping
  end

  factory :order2, class: Order do
    ordered_on { DateTime.now + 3.days }
    price { 2750 }
    status { 0 }
    channel { 0 }
    note { "綿98%ですが黒染めできますか？" }
    customer
    shipping
  end

  factory :order3, class: Order do
    ordered_on { DateTime.now + 1.days }
    price { 2750 }
    status { 0 }
    channel { 0 }
    note { "綿98%ですが黒染めできますか？" }
    customer
    shipping
  end
end