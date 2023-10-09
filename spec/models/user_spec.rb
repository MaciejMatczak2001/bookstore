require 'rails_helper'

RSpec.describe User, type: :model do

  it "creates a user with valid attributes" do
    expect(User.create(email: "email@gmail.com", password: "pa$$123", role: "user")).to be_valid
  end

  it "creates a user with admin role" do
    user = User.create(email: "admin@gmail.com", password: "pa$$123", role: "admin")
    expect(user.role).to eq("admin")
  end

  it "creates a user with user role" do
    user = User.create(email: "email@gmail.com", password: "pa$$123", role: "user")
    expect(user.role).to eq("user")
  end

  it "doesnt allow to create two accounts with same email" do
    user = User.create(email: "email@gmail.com", password: "pa$$123", role: "user")
    expect(User.create(email: "email@gmail.com", password: "pa$$321", role: "user")).to_not be_valid
  end

  it "doesnt allow to create account with wrong email format" do
    expect(User.create(email: "email", password: "pa$$321", role: "user")).to_not be_valid
  end

  it "doesnt allow to create account when email is empty string" do
    expect(User.create(email: " ", password: "pa$$321", role: "user")).to_not be_valid
  end

  it "doesnt allow to create account when email is nil" do
    expect(User.create(email: nil, password: "pa$$321", role: "user")).to_not be_valid
  end

  it "doesnt allow to create account when password is empty string" do
    expect(User.create(email: "email@gmail.com", password: " ", role: "user")).to_not be_valid
  end

  it "doesnt allow to create account when password is nil" do
    expect(User.create(email: "email@gmail.com", password: nil, role: "user")).to_not be_valid
  end

  it "doesnt allow to create account when password is shorter than 3" do
    expect(User.create(email: "email@gmail.com", password: "12", role: "user")).to_not be_valid
  end

  it "doesnt allow to create account when password is longer or eq to 20" do
    expect(User.create(email: "email@gmail.com", password: "123456789!@#$%^&*(111", role: "user")).to_not be_valid
  end

  it "doesnt allow to create account when role is nil" do
    expect(User.create(email: "email@gmail.com", password: "12", role: nil)).to_not be_valid
  end
end
