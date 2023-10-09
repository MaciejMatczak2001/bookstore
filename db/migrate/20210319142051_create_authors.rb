class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_index :authors, [ :first_name, :last_name ]
  end
end
