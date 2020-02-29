require 'csv'
RSpec.shared_context 'project setup' do
  before do
    # 都道府県データ
    CSV.foreach('db/data/town.csv', headers: true) do |row|
      FactoryBot.create(:town,
                        town_id: row['town_id'],
                        town_name: row['town_name'])
    end

    # 市区町村の位置データ
    CSV.foreach('db/data/test_city.csv', headers: true) do |row|
      FactoryBot.create(:city_place,
                        city_name: row['city_name'],
                        city_id: row['city_id'],
                        lng: row['lng'],
                        lat: row['lat'],
                        town_id: 33)
    end
  end
end
