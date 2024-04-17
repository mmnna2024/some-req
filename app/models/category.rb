class Category < ApplicationRecord
  has_many :items
  before_destroy :cannot_destroy_if_relation_with_orders

  validates :name, :price, presence: true
  validates :name, uniqueness: true

  scope :sort_by_true_latest, -> {order(display: :desc, created_at: :desc)}

  private

  def cannot_destroy_if_relation_with_orders
    if self.items.present?
      throw :abort
    end
  end
end
