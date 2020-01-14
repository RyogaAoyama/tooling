class CreateCityPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :city_places, id: false do |t|
      t.string :city_id, primary_key: true, limit: 6
      t.string :city_name, null: false
      t.decimal :lng, null: false, precision: 9, scale: 6
      t.decimal :lat, null: false, precision: 8, scale: 6
      t.references :town, null: false, type: :string, limit: 2

      t.timestamps
    end
    add_foreign_key :city_places, :towns, colmun: :town_id, primary_key: :town_id
  end
end
