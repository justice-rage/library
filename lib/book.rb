class Book
    attr_reader :id
    attr_accessor :name, :author_id
  
    def initialize(attributes)
      @name = attributes.fetch(:name)
      @author_id = attributes.fetch(:author_id)
      @id = attributes.fetch(:id)
    end
  
    def ==(book_to_compare)
      if book_to_compare != nil
        (self.name() == book_to_compare.name()) && (self.author_id() == book_to_compare.author_id())
      else
        false
      end
    end
  
    def self.all
      returned_books = DB.exec("SELECT * FROM books;")
      books = []
      returned_books.each() do |book|
        name = book.fetch("name")
        author_id = book.fetch("author_id").to_i
        id = book.fetch("id").to_i
        books.push(Book.new({:name => name, :author_id => author_id, :id => id}))
      end
      books
    end
  
    def save
      result = DB.exec("INSERT INTO books (name, author_id) VALUES ('#{@name}', #{@author_id}) RETURNING id;")
      @id = result.first().fetch("id").to_i
    end
  
    def self.find(id)
      book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
      if book
        name = book.fetch("name")
        author_id = book.fetch("author_id").to_i
        id = book.fetch("id").to_i
        Book.new({:name => name, :author_id => author_id, :id => id})
      else
        nil
      end
    end
  
    def update(name, author_id)
      @name = name
      @author_id = author_id
      DB.exec("UPDATE books SET name = '#{@name}', author_id = #{@author_id} WHERE id = #{@id};")
    end
  
    def delete
      DB.exec("DELETE FROM books WHERE id = #{@id};")
    end
  
    def self.clear
      DB.exec("DELETE FROM books *;")
    end
  
    def self.find_by_author(auth_id)
      books = []
      returned_books = DB.exec("SELECT * FROM books WHERE author_id = #{auth_id};")
      returned_books.each() do |book|
        name = book.fetch("name")
        id = book.fetch("id").to_i
        books.push(Book.new({:name => name, :author_id => auth_id, :id => id}))
      end
      books
    end
  
    def album
      Album.find(@author_id)
    end
  end