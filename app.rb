# frozen_string_literal: true

require 'http'
require 'sinatra'
require 'sinatra/reloader' if development?

require 'lazyrecord'
require_relative 'models/api_book'
require_relative 'models/book'
require_relative 'helpers/book_helper'

helpers BookHelper

get '/' do
  erb :index, :layout => false
end

get '/search' do
  @input = params['p']&.gsub(' ', '+')
  uri = "https://www.googleapis.com/books/v1/volumes?q=#{@input}"
  res = {}
  unless @input.nil? || @input.empty?
    req = HTTP.headers(accept: 'application/json').get(uri)
    res = req.parse
  end

  unless res.empty?
    @api_books = res['items'].map { |book| APIBook.create(book) }
  end

  erb :search
end

get '/books/:book_uid?' do
  book_uid = params[:book_uid]
  @my_book = Book.all.find { |el| el.uid == book_uid }
  erb :books
end

post '/books/:book_uid' do
  book_uid = params[:book_uid]
  book_state = params['book_state']

  my_book = Book.find { |el| el.uid == book_uid }
  if my_book.nil?
    selected = APIBook.find { |book| book.uid == book_uid }
    Book.create(selected, book_state)
  else
    my_book.update_notes!(params['notes'])
    my_book.update_state!(book_state)
  end
  redirect "/books/#{book_uid}"
end

get '/my_books' do
  @my_books = Book.all
  erb :my_books
end

post '/my_books' do
  book_uid = params['uid']
  print(book_uid)
  target = Book.find{|element| element.uid == book_uid}.id
  Book.delete(target)
  redirect '/my_books'
end

get '/index' do 
   redirect '/search'
end