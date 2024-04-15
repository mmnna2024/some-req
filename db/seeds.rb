Admin.create!(user_id: "admin", password: "aaaaaa")

# カテゴリの作成
categories = [
  ["Tシャツ", 2750],
  ["シャツ", 2750],
  ["ワンピース", 2750],
  ["パンツ", 3300],
  ["デニムパンツ", 3300],
  ["ジャケット", 4400],
  ["パーカー", 4400],
  ["コート", 4400],
]

categories.each do |name, price|
  Category.create!(name: name, price: price, display: true)
end

# 送料の作成
shippings = [
  ["関東・南東北・信越・北陸・中部", 1529],
  ["北東北・関西", 1650],
  ["北海道・九州", 2013],
  ["沖縄", 2739],
]

shippings.each do |name, price|
  Shipping.create!(name: name, price: price)
end

# 顧客の作成
50.times do |i|
  Customer.create!(
    name: "Customer #{i + 1}",
    email: "customer#{i}@example.com",
    phonenumber: "000-1234-567#{i}",
    address: "123 Example St, City #{i}",
    sex: [0, 1].sample,
    age: rand(18..60),
  )
end

# 注文とアイテムの作成
customers = Customer.all
shippings = Shipping.all
categories = Category.all

300.times do |i|
  random_date = Time.new(2022).beginning_of_year + rand((Time.new(2025).beginning_of_year - Time.new(2022).beginning_of_year).to_i)

  order = Order.create!(
    ordered_on: random_date,
    status: [0, 1].sample,
    channel: rand(0..2),
    price: 0,
    note: "Note #{i}",
    customer: customers.sample,
    shipping: shippings.sample,
  )

  total_order_price = 0

  rand(1..5).times do # 1から5までのランダムな回数でアイテムを作成
    item = Item.create!(
      order: order,
      category: categories.sample,
      price: categories.sample.price,
      order_id: order.id,
    )
    total_order_price += item.price
  end
  order.update!(price: total_order_price)
end

puts "Seed data created successfully!"
