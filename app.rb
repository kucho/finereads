# frozen_string_literal: true

require 'http'
require 'sinatra'
require 'sinatra/reloader' if development?

require 'lazyrecord'
require_relative 'models/api_book'
require_relative 'models/book'
require_relative 'helpers/book_helper'

helpers BookHelper

use Rack::MethodOverride

get '/' do
  erb :index
end

get '/search' do
  @input = params['p']&.gsub(' ', '+')
  uri = "https://www.googleapis.com/books/v1/volumes?q=#{@input}"
  res = {}
  unless @input.nil? || @input.empty?
    res = HTTP.headers(accept: 'application/json').get(uri).parse
  end

  unless res.empty?
    @api_books = res['items'].map { |book| APIBook.create(book) }
  end

  erb :search
end

get '/books/:book_uid' do
  book_uid = params[:book_uid]
  @sample_book = APIBook.all.find { |el| el.uid == book_uid }
  erb :book_detail
end

get '/my_books/:book_uid?' do
  book_uid = params[:book_uid]

  if book_uid.nil?
    @my_books = Book.all
    erb :my_books
  else
    @my_book = Book.all.find { |el| el.uid == book_uid }
    erb :my_book_info
  end
end

post '/my_books/:book_uid' do
  book_uid = params[:book_uid]
  book_state = params['book_state']
  selected = APIBook.find { |book| book.uid == book_uid }
  Book.create(selected, book_state)
  redirect '/my_books/'
end

patch '/my_books/:book_uid' do
  book_uid = params[:book_uid]
  book_state = params['book_state']
  my_book = Book.find { |el| el.uid == book_uid }
  my_book.update_notes!(params['notes'])
  my_book.update_state!(book_state)
  redirect '/my_books/'
end

delete '/my_books/:book_uid' do
  book_uid = params['book_uid']
  print(book_uid)
  target = Book.find { |element| element.uid == book_uid }.id
  Book.delete(target)
  redirect '/my_books/'
end