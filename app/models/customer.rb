class Customer < ApplicationRecord
  has_many :orders

  enum sex: [:male, :female]

  def self.ransackable_attributes(auth_object = nil)
    ["address", "age", "created_at", "email", "id", "name", "phonenumber", "sex", "updated_at"]
  end
end
