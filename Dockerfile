FROM ruby:latest

# Устанавливаем нужные пакеты
RUN apt-get update && \
    apt-get install -y build-essential nodejs libc6-dev

# Устанавливаем правильную версию Bundler
RUN gem install bundler -v 2.4.20

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "jekyll", "serve"]