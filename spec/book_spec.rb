require 'spec_helper'

describe '#Book' do

 #author variable dry - before(:each)

  describe('#==') do
    it("is the same book if it has the same attributes as another book") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name =>"Naima",:author_id => author.id,:id => nil)
      book2 = Book.new(:name =>"Naima", :author_id => author.id, :id =>nil)
      expect(book).to(eq(book2))
    end
  end

  describe('.all') do
    it("returns a list of all songs") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name => "Giant Steps", :author_id => author.id, :id => nil)
      book.save()
      book2 = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book2.save()
      expect(Book.all).to(eq([book, book2]))
    end
  end

  describe('.clear') do
    it("clears all songs") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name => "Giant Steps", :author_id => author.id, :id => nil)
      book.save()
      book2 = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book2.save()
      Book.clear()
      expect(Book.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a book") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book.save()
      expect(Book.all).to(eq([book]))
    end
  end

  describe('.find') do
    it("finds a book by id") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name => "Giant Steps", :author_id => author.id, :id => nil)
      book.save()
      book2 = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book2.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end

  describe('#update') do
    it("updates an book by id") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book.save()
      book.update("Mr. P.C.", author.id)
      expect(book.name).to(eq("Mr. P.C."))
    end
  end

  describe('#delete') do
    it("deletes an book by id") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name => "Giant Steps", :author_id => author.id,:id => nil)
      book.save()
      book2 = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book2.save()
      book.delete()
      expect(Book.all).to(eq([book2]))
    end
  end

  describe('.find_by_author') do
    it("finds songs for an author") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      author2 = Author.new(:name => "Blue", :id => nil)
      author2.save
      book = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book.save()
      book2 = Book.new(:name => "California", :author_id => author2.id , :id => nil)
      book2.save()
      expect(Book.find_by_author(author2.id)).to(eq([book2]))
    end
  end

  describe('#author') do
    it("finds the author a book belongs to") do
      author = Author.new({:name => "Pizza", :id => nil})
      author.save()
      book = Book.new(:name => "Naima", :author_id => author.id, :id => nil)
      book.save()
      expect(book.author()).to(eq(author))
    end
  end
end