# frozen_string_literal: true

# Saved book
class Book < LazyRecord

  attr_reader :cover, :title, :authors, :date, :uid
  attr_accessor :notes, :state

  def initialize(book_obj, state)
    @state = state
    @date = Time.now
    @uid = book_obj.uid
    @title = book_obj.title
    @cover = book_obj.thumbnail
    @authors = book_obj.authors
    @notes = ''
  end

  def update_notes!(notes)
    @notes = notes
    save
  end

  def update_state!(state)
    @state = state
    save
  end
end
