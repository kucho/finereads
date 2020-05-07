require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/Libro"

get "/" do
  erb :index
end