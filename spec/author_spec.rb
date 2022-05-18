require('spec_helper')

describe '#Author' do

  describe('#save') do
    it("saves an author") do
      author = Author.new({:name => "Giant Steps",:id => nil}) # nil added as second argument
      author.save()
      author2 = Author.new({:name => "Blue",:id => nil}) 
      author2.save()
      expect(Author.all).to(eq([author, author2]))
    end
  end
  
  describe('.all') do
    it("returns an empty array when there are no authors") do
      expect(Author.all).to(eq([]))
    end
  end

  describe('.all') do
    it("returns an array of all authors in the database") do
      author = Author.new({:name => "Giant Steps",:id => nil})
      author.save
      author2 = Author.new({:name => "Blue",:id => nil})
      author2.save
      expect(Author.all).to(eq([author, author2]))
    end
  end
  
   
  describe('#==') do
    it("is the same author if it has the same attributes as another author") do
      author = Author.new({:name => 'Blue',:id => nil})
      author2 = Author.new({:name => 'Blue',:id => nil})
      # expect(author).to(eq(author2))
      expect(author == author2).to(eq(true))
    end
  end
  
  describe('.clear') do
    it('clears all authors') do
      author = Author.new(:name =>'Giant Steps',:id => nil)
      author.save()
      author2 = Author.new(:name =>'Blue',:id => nil)
      author2.save()
      Author.clear
      expect(Author.all).to(eq([]))
    end
  end

  describe('.find') do
    it('finds an author by id') do
      author = Author.new(:name => 'Giant Steps',:id => nil)
      author.save()
      author2 = Author.new(:name =>'Blue',:id => nil)
      author2.save()
      expect(Author.find(author.id)).to(eq(author))
    end
  end

  describe('#update') do
    it('updates an author by id') do
      author = Author.new(:name =>'Giant Steps',:id => nil)
      author.save()
      author.update('A Love Supreme')
      expect(author.name).to(eq('A Love Supreme'))
    end
  end 

  describe('#delete') do
    it("deletes an author by id") do
      author = Author.new(:name =>"Giant Steps",:id => nil)
      author.save()
      author2 = Author.new(:name =>"Blue",:id => nil)
      author2.save()
      author.delete()
      expect(Author.all).to(eq([author2]))
    end
  end

#   describe('#delete') do
#     it("deletes all songs belonging to a deleted author") do
#       author = Author.new({:name => "A Love Supreme", :id => nil})
#       author.save()
#       song = Song.new({:name => "Naima", :album_id => author.id, :id => nil})
#       song.save()
#       author.delete()
#       expect(Song.find(song.id)).to(eq(nil))
#     end
#   end

#   describe('#songs') do
#     it("returns an author's songs") do
#       Author.clear()
#       author = Author.new({:name => "Giant Steps", :id => nil})
#       author.save()
#       song = Song.new({:name => "Naima", :album_id => author.id, :id => nil})
#       song.save()
#       song2 = Song.new({:name => "Cousin Mary", :album_id => author.id, :id => nil})
#       song2.save()
#       expect(author.songs).to(eq([song, song2]))
#     end
  end      
  
  # ----- WIP -----      
  # describe('.search') do
  #   it("searches for an author by author name") do
  #     author = Author.new("Giant Steps", nil)
  #     author.save
  #     author2 = Author.new("Love Supreme", nil)
  #     author2.save
  #     album3 = Author.new('Giant Steps', nil)
  #     album3.save
  #     expect(Author.search("Giant Steps")).to(eq(author))
  #     #CHANGED FROM LOWERCASE
  #   end
  # end

end