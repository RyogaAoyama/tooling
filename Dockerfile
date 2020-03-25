FROM ruby:2.6.5

# yarnをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN apt-get install -y vim

# 作業ディレクトリを作成
RUN mkdir /tooling

# Dockerfile内の環境変数を設定
ENV ROOT=/tooling

# 起点ディレクトリを設定
WORKDIR $ROOT


# Gemfileをコンテナ内に追加
ADD ./Gemfile $ROOT/Gemfile
ADD ./Gemfile.lock $ROOT/Gemfile.lock

# gemをインストール
RUN gem install bundler
RUN bundle install
ADD . $ROOT
