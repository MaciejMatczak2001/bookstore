require 'rails_helper'

RSpec.describe Book, type: :model do
  it "creates a book with valid attributes" do
    expect(Book.create(title: "Dziady", price: 100.0, published: true, quantity: 10)).to be_valid
  end

  it "doesnt create a book when title is an empty string" do
    expect(Book.create(title: " ", price: 100.0, published: true, quantity: 10)).to_not be_valid
  end

  it "doesnt create a book when title is a nil" do
    expect(Book.create(title: nil, price: 100.0, published: true, quantity: 10)).to_not be_valid
  end

  it "doesnt create a book when price is nil" do
    expect(Book.create(title: "Dziady", price: nil, published: true, quantity: 10)).to_not be_valid
  end

  it "doesnt create a book when quantity is nil" do
    expect(Book.create(title: "Dziady", price: 100.0, published: true, quantity: nil)).to_not be_valid
  end

  it "doesnt create a book when published is nil" do
    expect(Book.create(title: "Dziady", price: 100.0, published: nil, quantity: 10)).to_not be_valid
  end

  it "invloves book to :published when :published attribute is true" do
    book = Book.create(title: "Dziady", price: 44.0, published: true, quantity: 10)

    expect(Book.published.first).to eq book
  end

  it "doesnt invlove book to :published when :published attribute is false" do
    book = Book.create(title: "Dziady", price: 44.0, published: false, quantity: 10)

    expect(Book.published.count).to eq(0)
  end
  
end
