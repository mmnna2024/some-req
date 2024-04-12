FactoryBot.define do
  factory :admin, class: Admin do
    user_id { "admin" }
    password { "AbCd9876" }
  end
end