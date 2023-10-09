FROM ruby:2.7.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get -y install nodejs npm yarn && \
    gem install bundler

COPY docker/entrypoint.sh /entrypoint.sh
COPY docker/webpack_entrypoint.sh /webpack_entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR "/app"
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
