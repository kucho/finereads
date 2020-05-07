class Libro
  attr_accessor :id, :cover, :title, :author, :status, :date

  def initialize(id, cover, title, author, status, date)
    @id = id
    @cover = cover
    @title = title
    @author = author
    @status = status
    @date = date
  end
end