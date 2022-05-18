require 'spec_helper'

describe '#Book' do

  describe('.all') do
    it('returns an empty array when there are no books') do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a book') do
      book = Book.new({:name => "Ambeix", :id => nil}) # nil added as second argument
      book.save()
      book2 = Book.new({:name => "Bathory", :id=> nil}) # nil added as second argument
      book2.save()
      expect(Book.all).to(eq([book, book2]))
    end
  end

  describe('#==') do
    it('is the same book if it has the same attributes as another book') do
      book = Book.new({:name => "Amebix", :id => nil})
      book2 = Book.new({:name => "Amebix", :id => nil})
      expect(book).to(eq(book2))
    end
  end
  
  describe('#update') do
    it('adds an author to a book') do
      book = Book.new({:name => "John Coltrane", :id => nil})
      book.save()
      author = Author.new({:name => "A Love Supreme", :id => nil})
      author.save()
      book.update({:author_name => "A Love Supreme"})
      expect(book.authors).to(eq([author]))
    end
  end
  
  describe('.find') do
    it('finds an book by id') do
      book = Book.new({:name => "Amebix", :id => nil})
      book.save()
      book2 = Book.new({:name => "Bathory", :id => nil})
      book2.save()
      expect(Book.find(book.id)).to(eq(book))
    end
  end

  describe('.clear') do
    it('clears all books') do
      book = Book.new({:name => "Amebix", :id => nil})
      book.save()
      book2 = Book.new({:name => "Bathory", :id => nil})
      book2.save()
      Book.clear()
      expect(Book.all).to(eq([]))
    end
  end

  describe('#delete') do
    it('deletes a book and author') do
      book = Book.new({:name => "Amebix", :id => nil})
      book.save()
      author = Author.new({:name => "Whos the Enemy", :id => nil})
      author.save()
    #   song = Song.new({:name => "Carnage", :album_id => author.id, :id => nil})
    #   song.save()
      book.delete()
      expect(Book.find(book.id)).to(eq(nil))
    end
  end

end  
