require('sinatra')
require('sinatra/reloader')
require('./lib/author')
# require('./lib/SONG')
require('./lib/book')
require('pry')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "library"})

# ----- Album route ----
get('/') do
  # binding.pry
  redirect to('/albums')
  # @albums = Album.all #update code pg18
  # erb(:albums)
  # "This will be our home page. '/' is always the root route in a Sinatra application."
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

post('/albums') do
  name = params[:album_name]
  author = Album.new({:name => name, :id => nil})
  author.save()
  redirect to('/albums')
end

get('/albums/:id') do
  @author = Album.find(params[:id].to_i())
  erb(:author)
end

get('/albums/:id/edit') do
  @author = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @author = Album.find(params[:id].to_i())
  @author.update({:name => params[:name], :book_name => params[:book_name]})
  redirect to('/albums')
end

delete('/albums/:id') do
  @author = Album.find(params[:id].to_i())
  @author.delete()
  redirect to('/albums')
end

# # ----- SONG route ------

# # get the detail for a specific SONG (ex: lyrics & SONGwriters)
# get('/albums/:id/SONGs/:SONG_id') do
#     @SONG = SONG.find(params[:SONG_id].to_i())
#     erb(:SONG)
#   end
  
#   # post a new SONG. After the SONG is added, sinatra will route to the view for the author the SONG belongs to
#   post('/albums/:id/SONGs') do
#     @author = Album.find(params[:id].to_i())
#     SONG = SONG.new({:name => params[:SONG_name], :album_id => @author.id, :id => nil})
#     SONG.save()
#     erb(:author)
#   end
  
#   # edit a SONG & then route back to the author view
#   patch('/albums/:id/SONGs/:SONG_id') do
#     @author = Album.find(params[:id].to_i())
#     SONG = SONG.find(params[:SONG_id].to_i())
#     SONG.update(params[:name], @author.id)
#     erb(:author)
#   end
  
#   # delete a SONG & then route back to the author view
#   delete('/albums/:id/SONGs/:SONG_id') do
#     SONG = SONG.find(params[:SONG_id].to_i())
#     SONG.delete()
#     @author = Album.find(params[:id].to_())
#     erb(:author)
#   end
  
  # ------ Search route -------
  
  # display search results page
  get('/results') do
    erb(:search_results)
  end
  
  # display results
  post('/results') do
    erb(:search_results)
  end
  
  # ------- book route -------
  
  # get a list of all books
  get('/books') do
    @books = book.all
    erb(:books)
  end
  
  # add a new book
  get('/books/new') do
    erb(:new_book)
  end
  
  # look at the detail page for a single author
  get('/books/:id') do
    @book = book.find(params[:id].to_i())
    erb(:book)
  end

  # add a new author to the list of books
post('/books') do
    name = params[:book_name]
    book = book.new({:name => name, :id => nil})
    book.save()
    redirect to('/books')
  end
  
  # update a single author
  patch('/books/:id') do
    @book = book.find(params[:id].to_i())
    @book.update(:name => params[:name], :album_name => params[:album_name])
    redirect to('/books')
  end
  
  # delete an author from list
  delete('/books/:id') do
    @book = book.find(params[:id].to_i())
    @book.delete()
    redirect to('/books')
  end

#   # Get the detail for a specific SONG such as lyrics and SONGwriters.
# get('/albums/:id/SONGs/:SONG_id') do
#     @SONG = SONG.find(params[:SONG_id].to_i())
#     erb(:SONG)
#   end
  
#   # Post a new SONG. After the SONG is added, Sinatra will route to the view for the author the SONG belongs to.
#   post('/albums/:id/SONGs') do
#     @author = Album.find(params[:id].to_i())
#     SONG = SONG.new({:name => params[:SONG_name],:album_id => @author.id,:id => nil})
#     SONG.save()
#     erb(:author)
#   end
  
#   # Edit a SONG and then route back to the author view.
#   patch('/albums/:id/SONGs/:SONG_id') do
#     @author = Album.find(params[:id].to_i())
#     SONG = SONG.find(params[:SONG_id].to_i())
#     SONG.update(params[:name], @author.id)
#     erb(:author)
#   end
  
#   # Delete a SONG and then route back to the author view.
#   delete('/albums/:id/SONGs/:SONG_id') do
#     SONG = SONG.find(params[:SONG_id].to_i())
#     SONG.delete
#     @author = Album.find(params[:id].to_i())
#     erb(:author)
#   end