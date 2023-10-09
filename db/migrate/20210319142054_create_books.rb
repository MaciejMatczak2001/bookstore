class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.boolean :published

      t.timestamps
    end

    add_index :books, :published
  end
end
