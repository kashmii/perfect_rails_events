FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
# nokogiri関連でエラーが出るのを防ぐ
RUN bundle config set force_ruby_platform true
RUN bundle install
COPY . /app
RUN curl https://deb.nodesource.com/setup_12.x | bash
# =wget= HTTPアクセスをしてコンテンツをファイルに保存するコマンド。 curlでも同じようなことができるが、
# curlと違ってリンクをたどりながら再帰的にたくさんのファイルをダウンロードすることができる
RUN wget -qO - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn postgresql-client