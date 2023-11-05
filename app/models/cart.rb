class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def calculate_total_price
    price = 0
    cart_items.each do |cart_item|
      price += cart_item.book.price * cart_item.quantity
    end
    return price
  end
end
