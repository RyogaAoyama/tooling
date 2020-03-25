## PRODUCTION ##

# DB作成
bin/rails db:create RAILS_ENV=production

# DBマイグレーション
bin/rails db:migrate RAILS_ENV=production

# 初期データ作成
bin/rails db:seed RAILS_ENV=production

# コンパイル
bin/rails assets:precompile RAILS_ENV=production



