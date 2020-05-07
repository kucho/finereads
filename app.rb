require 'sinatra'
require "sinatra/reloader" if development?



get '/' do
    erb :index
end


get '/mybooks' do
  erb :mybooks
end

get '/search' do
    erb :search
end

get '/books' do
    erb :books
end