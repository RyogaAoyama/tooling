# yarn最新化
yarn install

# DB作成
bin/rails db:create

# DBマイグレーション
bin/rails db:migrate

# 初期データ作成
bin/rails db:seed

# 各種サーバーを起動
bundle exec foreman start
