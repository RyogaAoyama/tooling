class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, unique: true, limit: 30
      t.string :password_digest, null: false, unique: true
      t.references :town, null: false, type: :string, limit: 2

      t.timestamps
    end
  end
end
