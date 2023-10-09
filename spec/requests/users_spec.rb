require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:admin) {User.create(email: "admin@gmail.com", password: "pa$$123", role: "admin")}
  let(:user) {User.create(email: "user@gmail.com", password: "1234a")}

  describe "GET /users" do
    it "shows all the users for the admin" do
      login(admin)

      get users_path
      expect(response).to have_http_status(200)
      expect(response.body).to include "Users"
    end

    it "responses with unauthorized status for users" do
      login(user)

      get users_path
      expect(response).to have_http_status(401)
    end
  end

  describe "GET /sign_up" do
    it "responses with OK status and shows Sign Up form" do
      get sign_up_path
  
      expect(response).to have_http_status(200)
      expect(response.body).to include "Sign Up"
    end
  end

  describe "POST /sign_up" do
    it "creates a user with valid credentials" do
      email =  "new_user@gmail.com"
      post sign_up_path, params: {email: email, password: "123"}

      expect(User.last.email).to eq email
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]). to eq "Account created"
    end

    it "doesnt allow to create two users with same email" do
      post sign_up_path, params: {email: user.email, password: "123"}

      expect(response).to redirect_to(sign_up_path)
      expect(flash[:alert]). to eq "Could not create the account"
    end
  end

  describe "DELETE /users/:id/destroy" do
    it "responses with unauthorized status for users" do
      login(user)

      delete user_path(user)
      expect(response).to have_http_status(401)
      expect(User.last).to eq user
    end

    it "deletes the user when this action is performed by an admin" do
      login(admin)
      delete user_path(user)

      expect(User.count).to eq 1
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to eq "User deleted"
    end
  end

  describe "POST /users/:id/block" do
    it "blocks the user while action is performed by an admin" do
      login(admin)

      post block_user_path(user)
      expect(flash[:notice]).to eq "User #{user.email} was blocked"
      expect(response).to redirect_to(users_path)
      expect(User.last.blocked).to eq true
    end

    it "responses with unauthorized status for users" do
      login(user)
      post block_user_path(user)
      expect(response).to have_http_status(401)
      expect(User.last.blocked).to_not eq true
    end
  end

  describe "POST /users/:id/unblock" do
    let(:blocked_user) {User.create(email: "em@wp.pl", password: "123", blocked: true)}
    it "unblocks the user while action is performed by an admin" do
      login(admin)

      post unblock_user_path(blocked_user)
      expect(flash[:notice]).to eq "User #{blocked_user.email} was unblocked"
      expect(response).to redirect_to(users_path)
      expect(User.last.blocked).to eq false
    end

    it "responses with unauthorized status for users" do
      login(user)

      post unblock_user_path(blocked_user)
      expect(response).to have_http_status(401)
      expect(User.last.blocked).to eq true
    end
  end
end
