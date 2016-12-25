FROM ruby:2.3.3
MAINTAINER jimmi@rl-hosting.de

RUN   apt-get update && \
      apt-get install -y \
      build-essential \
      nodejs

WORKDIR /tmp
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

RUN mkdir -p /app
WORKDIR /app

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]
