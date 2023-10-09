class AddBooksQuantity < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :quantity, :integer, default: 0
  end
end
