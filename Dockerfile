FROM ruby:2.3.1

ENV RACK_ENV=development

WORKDIR /lita

# Lets copy the gemfile stuff and bundle install to help with caching
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .
