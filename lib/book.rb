class Book 
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_Books = DB.exec("SELECT * FROM Books;")
    Books = []
    returned_Books.each() do |Book|
      name = Book.fetch("name")
      id = Book.fetch("id").to_i
      Books.push(Book.new({:name => name, :id => id}))
    end
    Books
  end

  def save
    result = DB.exec("INSERT INTO Books (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(Book_to_compare)
    self.name() == Book_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM Books *;")
  end

  def self.find(id)
    Book = DB.exec("SELECT * FROM Books WHERE id = #{id};").first
    if Book
      name = Book.fetch("name")
      id = Book.fetch("id").to_i
      Book.new({:name => name, :id => id})
    else
      nil
    end
  end

  def update(attributes)
      if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
        @name = attributes.fetch(:name)
        DB.exec("UPDATE Books SET name = '#{@name}' WHERE id = #{@id};")
      elsif (attributes.has_key?(:author_name)) && (attributes.fetch(:author_name) != nil)
        author_name = attributes.fetch(:author_name)
        author = DB.exec("SELECT * FROM authors WHERE lower(name)='#{author_name.downcase}';").first
        if author != nil
          DB.exec("INSERT INTO authors_Books (author_id, Book_id) VALUES (#{author['id'].to_i}, #{@id});")
        end
      end
    end

  def delete
    DB.exec("DELETE FROM authors_Books WHERE Book_id = #{@id};")
    DB.exec("DELETE FROM Books WHERE id = #{@id};")
  end

  def authors
    authors = []
    results = DB.exec("SELECT author_id FROM authors_Books WHERE Book_id = #{@id};")
    results.each() do |result|
      author_id = result.fetch("author_id").to_i()
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      name = author.first().fetch("name")
      authors.push(Album.new({:name => name, :id => author_id}))
    end
    authors
  end

end