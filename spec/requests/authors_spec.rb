require 'rails_helper'

RSpec.describe "Authors", type: :request do
  let(:user) {User.create(email: "user@gmail.com", password: "1234a")}
  let(:admin) {User.create(email: "admin@gmail.com", password: "pa$$123", role: "admin")}
  let(:author) {Author.create(first_name: "Johnny", last_name: "Waltz")}

  describe "GET /authors" do
    it "shows index page for admin" do
      login(admin)

      get authors_path
      expect(response).to have_http_status(200)
      expect(response.body).to include '<h1 class = "center-align">Authors</h1>'
    end

    it "responses with unauthorized status for users" do
      login(user)

      get authors_path
      expect(response).to have_http_status(401)
    end

    it "responses with unauthorized status for not signed in people" do
      get authors_path
      expect(response).to have_http_status(401)
    end
  end

  describe "GET /authors/:id/edit" do
    it "shows edit page for admin" do
      login(admin)

      get edit_author_path(author)

      expect(response).to have_http_status(200)
      expect(response.body).to include "Editing author: #{author.full_name}"
    end

    it "responses with unauthorized status for users" do
      login(user)

      get edit_author_path(author)
      
      expect(response).to have_http_status(401)
    end

    it "responses with unauthorized status for not signed in people" do
      get edit_author_path(author)

      expect(response).to have_http_status(401)
    end

    describe "PATCH /authors/:id" do
      new_name = "new name"

      it "allows admins to update authors information" do
        login(admin)

        patch author_path(author), params: {first_name: new_name}
        author.reload
        expect(response).to redirect_to(authors_path)
        expect(author.first_name).to eq new_name
        expect(flash[:notice]).to eq "Author was successfully edited"
      end

      it "responses with unauthorized status for users" do
        login(user)
  
        patch author_path(author), params: {first_name: new_name}
        
        expect(response).to have_http_status(401)
        expect(author.first_name).to_not eq new_name
      end
  
      it "responses with unauthorized status for not signed in people" do
        patch author_path(author), params: {first_name: new_name}
  
        expect(response).to have_http_status(401)
        expect(author.first_name).to_not eq new_name
      end
    end
  end

  describe "DELETE /authors/:id/destroy" do
    it "allows admins to delete an author" do
      login(admin)

      delete author_path(author)
      expect(Author.count).to eq 0
      expect(response).to redirect_to(authors_path)
      expect(flash[:notice]).to eq "Author was successfully deleted"
    end

    it "responses with unauthorized status for users" do
      login(user)

      delete author_path(author)
      expect(Author.count).to eq 1
      expect(response).to have_http_status(401)
    end

    it "responses with unauthorized status for not signed in people" do
      delete author_path(author)
      expect(Author.count).to eq 1
      expect(response).to have_http_status(401)
    end
  end

end
