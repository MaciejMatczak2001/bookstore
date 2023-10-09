class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :cart_items, dependent: :destroy

  scope :published, -> { where(published: true) }

  validates :title, :price, :quantity, presence: true
  validates :published, inclusion: [true, false]

end