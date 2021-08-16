FROM ruby:3.0.0

RUN apt-get update -qq

ENV INSTALL_PATH /app
WORKDIR $INSTALL_PATH
RUN mkdir -p $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

ENV RAILS_ENV development
ENV RACK_ENV development

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["puma", "-C", "config/puma.rb"]
