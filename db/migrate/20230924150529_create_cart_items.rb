class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :book_id
      t.integer :quantity, default: 0
      t.timestamps
    end

    add_index :cart_items, :cart_id
    add_index :cart_items, :book_id
  
  end
end
