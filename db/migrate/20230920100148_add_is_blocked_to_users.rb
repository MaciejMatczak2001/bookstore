class AddIsBlockedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :blocked, :boolean, default: false
  end
end
