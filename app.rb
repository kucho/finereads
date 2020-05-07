require 'sinatra'
require "sinatra/reloader" if development?



get '/' do
    erb :index
end

get '/books' do
  erb :_mybooks
end