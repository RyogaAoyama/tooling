class CreateTowns < ActiveRecord::Migration[6.0]
  def change
    create_table :towns, id: false do |t|
      t.string :town_id, primary_key: true, limit: 2
      t.string :town_name, null: false

      t.timestamps
    end
  end
end
