FROM ruby:2.6.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /hello_app
COPY Gemfile Gemfile.lock /hello_app/
RUN bundle install

# コンテナー起動時に毎回実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
# x(実行権限)を+(与える)
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# コンテナがリッスンするport番号
EXPOSE 3000

# イメージ実行時に起動させる主プロセスを設定
CMD ["rails", "server", "-b", "0.0.0.0"]