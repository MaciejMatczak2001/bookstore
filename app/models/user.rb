class User < ApplicationRecord
  has_secure_password
  has_one :cart

  validates :email, uniqueness: true, format: {with: /\A^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$\z/ }

  validates :email, :password, :role, presence: true

  validates :password, length: { in: 3..20 } 
  
  enum role: [:user, :admin]

end
