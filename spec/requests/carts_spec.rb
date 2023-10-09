require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let(:user) {User.create(email: "user@gmail.com", password: "1234a")}
  let(:admin) {User.create(email: "admin@gmail.com", password: "pa$$123", role: "admin")}

  describe "GET /my_cart" do
    it "shows index for admins" do
      login(admin)

      get my_cart_path
      expect(response).to have_http_status(200)
      expect(response.body).to include "My Cart"
    end

    it "shows index for users" do
      login(user)

      get my_cart_path
      expect(response).to have_http_status(200)
      expect(response.body).to include "My Cart"
    end

    it "responses with unauthorized status for not signed in people" do
      get my_cart_path
      expect(response).to have_http_status(401)
    end
  end

  describe "POST /my_cart/:id/add" do
    context "book quantity > 0" do
      let(:book) {Book.create(title: "Amazing Book", price: 20, published: true, quantity: 10)}

      it "adds book to the cart of a user" do
        login(user)
        post add_cart_path(book), params: { id: book.id }
        cart_item = user.cart.cart_items.last
  
        expect(flash[:notice]).to eq("Book added")
        expect(cart_item.book).to eq(book)
        expect(cart_item.quantity).to eq 1
      end
  
      it "adds book to the cart of an admin" do
        login(admin)
  
        post add_cart_path(book), params: { id: book.id }
        cart_item = admin.cart.cart_items.last
  
        expect(flash[:notice]).to eq("Book added")
        expect(cart_item.book).to eq(book)
        expect(cart_item.quantity).to eq 1
      end
  
      it "doesnt add book for not signed people" do
        post add_cart_path(book), params: { id: book.id }
  
        expect(response).to have_http_status(401)
      end

      it "is possible to add one book twice" do
        login(user)

        post add_cart_path(book), params: { id: book.id }
        post add_cart_path(book), params: { id: book.id }
        cart_item = user.cart.cart_items.last
        expect(flash[:notice]).to eq("Book added")
        expect(cart_item.book).to eq(book)
        expect(cart_item.quantity).to eq 2
      end
    end

    context "book quantity < 0" do
      let(:book) {Book.create(title: "Amazing Book", price: 20, published: true, quantity: 0)}

      it "doesnt allow to add a book to cart for user" do
        login(user)
        
        post add_cart_path(book), params: { id: book.id }
        
        expect(flash[:alert]).to eq("Book is out of stock!")
        expect(user.cart.cart_items.count).to eq 0
      end

      it "doesnt allow to add a book to cart for admin" do
        login(admin)
        
        post add_cart_path(book), params: { id: book.id }
        
        expect(flash[:alert]).to eq("Book is out of stock!")
        expect(admin.cart.cart_items.count).to eq 0
      end
    end
  end

  describe "DELETE /carts/:id/destroy" do
    it "destroys the cart of a user" do
      Cart.create(user: user)
      login(user)

      delete cart_path(user.cart)
      expect(flash[:notice]).to eq "Cart cleared"
      expect(response).to redirect_to(my_cart_path)
    end

    it "destroys the cart of an admin" do
      Cart.create(user: admin)
      login(admin)

      delete cart_path(admin.cart)
      expect(flash[:notice]).to eq "Cart cleared"
      expect(response).to redirect_to(my_cart_path)
    end
  end

  describe "POST /carts/:id/remove_one" do
    let(:book) {Book.create(title: "Amazing Book", price: 20, published: true, quantity: 10)}
    context "there are multiple copies of same book in cart" do
      it "changes the quantity of cart_item by -1 for user" do
        Cart.create(user: user)
        CartItem.create(cart: user.cart, book: book, quantity: 3)
        login(user)
        
        cart_item = user.cart.cart_items.last        
        post remove_one_cart_path(cart_item)
        cart_item.reload
        expect(cart_item.quantity).to eq 2
      end

      it "changes the quantity of cart_item by -1 for admin" do
        Cart.create(user: admin)
        CartItem.create(cart: admin.cart, book: book, quantity: 3)
        login(admin)
        
        cart_item = admin.cart.cart_items.last        
        post remove_one_cart_path(cart_item)
        cart_item.reload
        expect(cart_item.quantity).to eq 2
      end
    end 

    context "there is one copy of the book in cart" do
      it "destorys the cart item when quantity reaches 0 for user" do
        Cart.create(user: user)
        CartItem.create(cart: user.cart, book: book, quantity: 1)
        login(user)

        cart_item = user.cart.cart_items.last        
        post remove_one_cart_path(cart_item)
        expect(user.cart.cart_items.count).to eq 0
      end

      it "destorys the cart item when quantity reaches 0 for admin" do
        Cart.create(user: admin)
        CartItem.create(cart: admin.cart, book: book, quantity: 1)
        login(admin)

        cart_item = admin.cart.cart_items.last
        post remove_one_cart_path(cart_item)
        expect(admin.cart.cart_items.count).to eq 0
      end
    end
  end

  describe "POST /carts/:id/remove_item" do
    let(:book) {Book.create(title: "Amazing Book", price: 20, published: true, quantity: 10)}
    it "destroys cart item for a user" do
      Cart.create(user: user)
      CartItem.create(cart: user.cart, book: book, quantity: 3)
      login(user)

      cart_item = user.cart.cart_items.last
      post remove_item_cart_path(cart_item)
      expect(user.cart.cart_items.count).to eq 0
    end

    it "destroys cart item for a user" do
      Cart.create(user: admin)
      CartItem.create(cart: admin.cart, book: book, quantity: 3)
      login(admin)

      cart_item = admin.cart.cart_items.last
      post remove_item_cart_path(cart_item)
      expect(admin.cart.cart_items.count).to eq 0
    end
  end
end
