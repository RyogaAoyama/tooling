# DBが起動するまで待機
sleep 10s

# DB作成
bin/rails db:create

# DBマイグレーション
bin/rails db:migrate

# 初期データ作成
bin/rails db:seed

# サーバー起動
bundle exec foreman start