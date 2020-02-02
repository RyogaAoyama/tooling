RSpec.shared_context "project setup" do
  before do
    town = FactoryBot.create(:town)
    # 市区町村の位置データ
    CSV.foreach("db/data/test_city.csv", headers: true) do |row|
      FactoryBot.create(:city_place,
        city_name: row["city_name"],
        city_id: row["city_id"],
        lng: row["lng"],
        lat: row["lat"],
        town_id: town.id
      )
    end
  end
end