class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def sum_all
    price = 0
    cart_items.each do |cart_item|
      price = price + cart_item.book.price * cart_item.quantity
    end

    return price
  end

end