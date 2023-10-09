require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "returns sum of cart_items in cart" do
    book1 = Book.create(title: "test", price: 10.0, published: true)
    book2 = Book.create(title: "test2", price: 12.0, published: true)

    user1 = User.create(email: "email@gmail.com", password: "1234")
    
    cart1 = Cart.create(user: user1)

    cart1.cart_items.create(book: book1, quantity: 2)
    cart1.cart_items.create(book: book2, quantity: 3)
    
    expect(cart1.sum_all).to eq(10.0 * 2 + 12.0 * 3)
  end
end
