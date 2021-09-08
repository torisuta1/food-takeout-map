# https://hub.docker.com/_/ruby
FROM ruby:3.0.1-alpine
RUN apk update && apk add --no-cache --update build-base tzdata bash yarn python2 imagemagick graphviz mysql-dev mysql-client

WORKDIR /food-takeout-map
ENV LANG="ja_JP.UTF-8"

COPY Gemfile Gemfile.lock ./
RUN bundle install --no-cache

COPY package.json yarn.lock ./
RUN yarn install && yarn cache clean

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
