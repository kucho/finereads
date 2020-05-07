require 'sinatra'


get '/' do
    erb :index
end

get '/books' do
    erb :books
end