# 出かけ先を見つける Web アプリ

![image](https://user-images.githubusercontent.com/39504783/77760396-9caa9480-7079-11ea-9d9d-db2fef0e0afe.png)

# 概要

休日の出かける先を探してくれる Web アプリです。

もうここに住み始めて早三年....。今週の休日はどこに出かけようか？

大体遊び尽くした気がするなぁ。

という時にこのアプリを使えば今まで知らなった場所を見つけることができます。

## URL

https://www.sk-spot.net

## ご利用にあたって

スムーズにご利用いただけるようにテストアカウントを用意しています。

ログインページに「すぐに利用する」ボタンがありますのでそちらからご利用ください。

![image](https://user-images.githubusercontent.com/39504783/77760677-180c4600-707a-11ea-8c7b-07e2b7b3872a.png)

# 機能一覧

- 行き先検索機能
- 訪問マップ機能
- 行き先登録 / 一覧 / 詳細 / 削除機能
- ユーザー登録 / 編集 / 削除機能
- ログイン / ログアウト機能

# 使用技術

## フロントエンド

- Vue.js ( 2.6.11 )
- Vuex ( 3.1.3 )
- Vuetify ( 2.2.18 )

## バックエンド

- Ruby ( 2.6.5 )
- Ruby on Rails ( 6.0.2 )

## テスト

- RSpec ( 3.9.0 )

## DB

- MySQL ( 5.7 )

## インフラ

- Docker / docker-compose
- Github Actions( CI )
- AWS( EC2 / VPC / ALB / Route53 / ACM )

## その他

- Rubocop
- Google Maps API ( Maps JavaScript API / Destance Matrix API / Places API )
- Trello (タスク管理)

# システム構成

![Untitled Diagram (2)](https://user-images.githubusercontent.com/39504783/77809952-66026780-70d5-11ea-806b-cf4f7da8c5c3.png)

# 製作したキッカケ

私の趣味はツーリングで、よく知り合いとツーリングに出かけます。

出かけた時、必ずこんなやりとりをします。

「今日どこ行く？」「うーん...。」「どこ行こう...。」

悩んでるこの時間！果てしなく勿体無い！秒速で目的地を決めたい！

ということで作りました。

# 最後に

お忙しい中最後までご覧いただきありがとうございました。

本アプリを通じて今まで知らなかった場所を発見して、少しでも楽しんでいただけたら幸いです。
