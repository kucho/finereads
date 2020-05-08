# frozen_string_literal: true

# A book from google's API
class APIBook < LazyRecord
  include Enumerable
  attr_reader :uid, :title, :authors,
              :description, :price,
              :buy_link, :thumbnail

  def initialize(book_json) # rubocop:todo Metrics/AbcSize
    @uid = book_json['id']
    @title = book_json['volumeInfo']['title']
    @authors = book_json['volumeInfo']['authors']
    @description = book_json['volumeInfo']['description']
    has_price = book_json['saleInfo']['listPrice']
    @price = has_price.nil? ? 'Not available' : has_price['amount']
    @buy_link = book_json['saleInfo']['buyLink']
    has_images = book_json['volumeInfo']['imageLinks']
    @thumbnail = has_images.nil? ? 'placeholder.png' : has_images['thumbnail']
  end
end
