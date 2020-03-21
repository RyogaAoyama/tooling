# # yarn最新化
# yarn install

# # DB作成
# bin/rails db:create RAILS_ENV=production

# # DBマイグレーション
# bin/rails db:migrate RAILS_ENV=production

# # 初期データ作成
# bin/rails db:seed RAILS_ENV=production

# # 各種サーバーを起動
# bundle exec foreman start

############################################

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


