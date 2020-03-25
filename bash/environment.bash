## PRODUCTION ##

# DBが起動するまで待機
sleep 15s

# DB作成
bin/rails db:create RAILS_ENV=production

# DBマイグレーション
bin/rails db:migrate RAILS_ENV=production

# 初期データ作成
bin/rails db:seed RAILS_ENV=production

# コンパイル
bin/rails assets:precompile RAILS_ENV=production

# サーバー起動
bundle exec rails s -p 3000 -b '0.0.0.0'



