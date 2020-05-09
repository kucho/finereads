# frozen_string_literal: true

# A book from google's API
class APIBook

  attr_reader :uid, :title, :authors,
              :description, :price,
              :buy_link, :thumbnail

  def initialize(book_json)
    @book_obj = book_json
    @uid = @book_obj['id']
    @title = @book_obj['volumeInfo']['title']
    @authors = @book_obj['volumeInfo']['authors']
    @description = fetch_description
    @price = check_price
    @buy_link = @book_obj['saleInfo']['buyLink']
    @thumbnail = check_thumbnail
  end

  def fetch_description
    req = HTTP.get(@book_obj['selfLink']).parse
    req['volumeInfo']['description']
  end

  def check_price
    has_price = @book_obj['saleInfo']['listPrice']
    has_price.nil? ? 'Not available' : has_price['amount']
  end

  def check_thumbnail
    has_images = @book_obj['volumeInfo']['imageLinks']
    has_images.nil? ? 'placeholder.png' : has_images['thumbnail']
  end
end
