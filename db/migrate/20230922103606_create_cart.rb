class CreateCart < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.integer :user_id
      
      t.timestamps
    end

    add_index :carts, :user_id
  end
end
