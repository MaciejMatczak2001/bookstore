module AuthenticationHelpers
  def login(user)
    post "/login", params: { email: user.email, password: user.password }
  end
end
