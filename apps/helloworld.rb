require 'sinatra'

# Setting IP address of the interface to listen on
set :bind, '0.0.0.0'

get '/' do
  "Hello World!"
end
