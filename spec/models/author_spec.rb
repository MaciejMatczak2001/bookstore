require 'rails_helper'

RSpec.describe Author, type: :model do
  it "returns the full_name of an author" do
    author = Author.create(first_name: "Juliusz", last_name: "Slowacki")

    expect(author.full_name).to eq "Juliusz Slowacki"
  end

  it "creates an author with valid attributes" do
    expect(Author.create(first_name: "Juliusz", last_name: "Slowacki")).to be_valid
  end

  it "doesnt create an author when first name is empty String" do
    expect(Author.create(first_name:"", last_name: "Slowacki")).to_not be_valid
  end

  it "doesnt create an author when first name is nil" do
    expect(Author.create(first_name: nil, last_name: "Slowacki")).to_not be_valid
  end

  it "doesnt create an author when last name is empty String" do
    expect(Author.create(first_name:"Juliusz", last_name: "")).to_not be_valid
  end

  it "doesnt create an author when last name is nil" do
    expect(Author.create(first_name:"Juliusz", last_name: nil)).to_not be_valid
  end

end
