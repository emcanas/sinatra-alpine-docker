#Dockerfile

The Dockerfile contains all the instructions that will allow you to build the image. The container will be a running instance of this image.

Once it is created, you can build :

	docker build -t helloworld .
	
	# -t : Option to give a name to the build
	# helloworld: name of the build
	# . : location of the dockerfile

and run the container:

	docker run -p 80:3000 helloworld
	
	# -p : ports specification
	# 80:3000  (from the host:from the container)
	# helloworld : name given previously to the build 

***

####Dockerfile content

** Alpine**
I have chosen this distribution of Linux, Alpline, to obtain a small image. It is possible to build it in on Ruby ("FROM ruby:lastest-version") but it would require around 1GB. Alpine is a nice tiny alternative.

	FROM alpine:3.2

**Ruby packages and dependencies**

Update, upgrade and add different Ruby packages.

	RUN apk update && \
		apk upgrade && \
		apk add $BUILD_PACKAGES
	
	RUN apk add ca-certificates 
	RUN apk add ruby 
	RUN apk add $RUBY_PACKAGES
	
And clean the cache after installation! Alpine stores the cache in that folder.

	 RUN rm -rf /var/cache/apk/*
	 
Provide environment for Ruby and install sinatra

	RUN bundle install
	RUN gem install sinatra --no-document

**Ports**

By default, Sinatra is on 4567 port (https://github.com/sinatra/sinatra) but I have reserved and exposed port 80, as this is a Web server application. I need also, to make it accessible from the localhost, so I have published on docker-compose.yml.

	ENV PORT 80
	EXPOSE 80

**Running ruby file**

The instruction to execute when running the image is the provided sinatra "helloworld" application:

	CMD ["ruby", "helloworld.rb"]

***
	 


	