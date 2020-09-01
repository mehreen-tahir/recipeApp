FROM starefossen/ruby-node

WORKDIR /usr/src/app

COPY Gemfile* ./
RUN bundle install
RUN bundle exec rails webpacker:install

COPY . ./
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
