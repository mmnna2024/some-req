FactoryBot.define do
  factory :admin, class: Admin do
    email { "admin@gmail.com" }
    password { "AbCd9876" }
  end
end