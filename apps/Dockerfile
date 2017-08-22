FROM alpine:3.2

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ca-certificates ruby ruby-io-console ruby-bundler
ENV APP_HOME /usr/app/

# Updates 
RUN apk update && \
    apk upgrade

# Install all required packages.
RUN apk add $BUILD_PACKAGES
RUN apk add $RUBY_PACKAGES

# Remove the apk cache
RUN rm -rf /var/cache/apk/*

# Copy local files to the image
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY * $APP_HOME

# Provide environment for Ruby
RUN bundle install
# Install sinatra
RUN gem install sinatra --no-document

# Start server
#  -> On a specific port (Sinatra by default is 4567)
#  -> Run the rb file
ENV PORT 80
EXPOSE 80

CMD ["ruby", "helloworld.rb"]
