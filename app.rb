require 'sinatra'


get '/' do
    erb :index
end

get '/search' do
    erb :search
end