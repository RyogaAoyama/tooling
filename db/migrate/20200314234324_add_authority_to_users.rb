class AddAuthorityToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authority, :integer, null: false, default: 0
  end
end
