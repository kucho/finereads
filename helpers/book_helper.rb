# frozen_string_literal: true

# Helpers for books
module BookHelper
  def fetch_book(uid)
    uri = "https://www.googleapis.com/books/v1/volumes/#{uid}"
    HTTP.get(uri).parse
  end
end
