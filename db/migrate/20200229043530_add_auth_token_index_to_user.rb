class AddAuthTokenIndexToUser < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :token, unique: true
  end
end
