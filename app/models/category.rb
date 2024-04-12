class Category < ApplicationRecord
  has_many :items
  before_destroy :cannot_destroy_if_relation_with_orders

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  
  private

  def cannot_destroy_if_relation_with_orders
    if self.items.present?
      throw :abort
    end
  end
end
