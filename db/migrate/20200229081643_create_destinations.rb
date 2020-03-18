class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :place_id, null: false
      t.string :name, null: false
      t.text :picture
      t.string :address
      t.decimal :review_rank
      t.integer :review_num
      t.boolean :is_visit, null: false, default: false
      t.decimal :lat, precision: 9, scale: 6, null: false
      t.decimal :lng, precision: 9, scale: 6, null: false
      t.datetime :visited_at, default: '0000-00-00'

      t.timestamps
    end
  end
end
