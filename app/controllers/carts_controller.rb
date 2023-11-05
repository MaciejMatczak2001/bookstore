class CartsController < ApplicationController
  include Available
  
  before_action :logged_in_content
  before_action :set_cart


  def index
  end

  def add
    book = Book.find(params[:id])
    
    if book.quantity == 0
      redirect_back(fallback_location: root_path, alert: "Book is out of stock!") and return
    end
  
    cart_item = @cart.cart_items.find_by(book: book)
  
    if cart_item
      cart_item.increment!(:quantity)
      redirect_back(fallback_location: root_path)
    else
      cart_item = @cart.cart_items.create(book: book, quantity: 1)
      redirect_back(fallback_location: root_path, notice: "Book added to cart")
    end
  end

  def destroy
    current_user.cart.destroy 
    redirect_to my_cart_path, notice: "Cart cleared"
  end

  # reduces the quantity of an item in the shopping cart if quantity reaches 0 it removes it
  def remove_one_book
    cart_item = CartItem.find(params[:id])

    if cart_item.quantity > 1
      cart_item.decrement!(:quantity)
    else
      cart_item.destroy
    end
    redirect_back(fallback_location: root_path)
  end

  # removes cart item from the cart
  def remove_item
    @cart.cart_items.find(params[:id]).destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
  
end
