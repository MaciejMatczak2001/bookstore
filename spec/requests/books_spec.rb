require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:user) {User.create(email: "user@gmail.com", password: "1234a")}
  let(:book) {Book.create(title: "Test", price: 10.0, published: true)}
  let(:admin) {User.create(email: "admin@gmail.com", password: "pa$$123", role: "admin")}

  describe "GET /books" do
    it "responses with success" do
      get books_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /books/:id" do
    it "responses with success" do
      get book_path(book)
      expect(response).to have_http_status(200)
      expect(response.body).to include "Title: #{book.title}"
    end
  end

  describe "GET /books/:id/edit" do
    it "responses with success for admin" do
      login(admin)

      get edit_book_path(book)
      expect(response).to have_http_status(200)
      expect(response.body).to include "Editing book: #{book.title}"
    end

    it "responses with unauthorized status for users" do
      login(user)

      get edit_book_path(book)
      expect(response).to have_http_status(401)
    end

    it "responses with unauthorized status for not signed in people" do
      get edit_book_path(book)
      expect(response).to have_http_status(401)
    end
  end

  describe "PATCH /books/:id" do
    new_title = "new title"

    it "allows book to be updated for admin" do
      login(admin)

      patch book_path(book), params: {title: new_title}
      book.reload
      expect(response).to redirect_to(root_path)
      expect(book.title).to eq new_title
    end

    it "responses with unauthorized status for users" do
      login(user)

      patch book_path(book), params: {title: new_title}
      book.reload
      expect(response).to have_http_status(401)
      expect(book.title).to_not eq new_title
    end

    it "responses with unauthorized status for not signed in people" do
      patch book_path(book), params: {title: new_title}
      book.reload
      expect(response).to have_http_status(401)
      expect(book.title).to_not eq new_title
    end
  end

  describe "DELETE /books/:id/destroy" do
    it "allows book to be deleted by admin" do
      login(admin)
      delete book_path(book)

      expect(Book.count).to eq 0
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq "Book was successfully deleted"
    end

    it "responses with unauthorized status for users" do
      login(user)

      delete book_path(book)
      expect(Book.count).to eq 1
      expect(response).to have_http_status(401)
    end

    it "responses with unauthorized status for not signed in people" do
      delete book_path(book)
      expect(Book.count).to eq 1
      expect(response).to have_http_status(401)
    end
  end

end
