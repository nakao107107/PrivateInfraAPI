FROM ruby:2.6.5

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

# 作業ディレクトリの作成、設定
RUN mkdir /app
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

#bundlerをinstall
RUN gem install bundler -v "1.17.2"

RUN bundle install

ADD . $APP_ROOT
