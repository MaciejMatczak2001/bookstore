require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) {User.create(email: "user@gmail.com", password: "1234a")}
  let(:blocked_user) {User.create(email: "user@gmail.com", password: "1234a", blocked: true)}

  describe "GET /login" do
    it "shows login page" do
      get login_path
      expect(response).to have_http_status(200)
      expect(response.body).to include "Log In"
    end
  end

  describe "POST /login" do
    context "user is not blocked" do
      it "allows user to login with correct credentials" do
        post login_path, params: {email: user.email, password: user.password}
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq "Welcome! Login Successful"
      end

      it "doesnt login user with wrong credentials" do
        post login_path, params: {email: user.email, password: "wrong"}
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq "Login failed" 
      end
    end

    context "user is blocked" do
      it "informs user that he is blocked with correct credentials" do
        post login_path, params: {email: blocked_user.email, password: blocked_user.password}
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq "You are blocked, please contact support"
      end

      it "doesnt show the blocked message if user used wrong credentials" do
        post login_path, params: {email: blocked_user.email, password: "wrong"}
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq "Login failed" 
      end
    end
  end

  describe "POST /logout" do
    it "signs out the  user" do
      login(user)

      post logout_path
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Logged out")
    end
  end
end
