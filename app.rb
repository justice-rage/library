require('sinatra')
require('sinatra/reloader')
require('./lib/author')
require('./lib/Book')
# require('./lib/artist')
require('pry')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "library"})

# ----- Author route ----
get('/') do
  # binding.pry
  redirect to('/authors')
  # @authors = Author.all #update code pg18
  # erb(:authors)
  # "This will be our home page. '/' is always the root route in a Sinatra application."
end

get('/authors') do
  @authors = Author.all
  erb(:authors)
end

get('/authors/new') do
  erb(:new_author)
end

post('/authors') do
  name = params[:author_name]
  author = Author.new({:name => name, :id => nil})
  author.save()
  redirect to('/authors')
end

get('/authors/:id') do
  @author = Author.find(params[:id].to_i())
  erb(:author)
end

get('/authors/:id/edit') do
  @author = Author.find(params[:id].to_i())
  erb(:edit_author)
end

patch('/authors/:id') do
  @author = Author.find(params[:id].to_i())
  @author.update({:name => params[:name], :artist_name => params[:artist_name]}) IDK
  redirect to('/authors')
end

delete('/authors/:id') do
  @author = Author.find(params[:id].to_i())
  @author.delete()
  redirect to('/authors')
end

# ----- Book route ------

# get the detail for a specific Book (ex: lyrics & Bookwriters)
get('/authors/:id/Books/:book_id') do
    @Book = Book.find(params[:book_id].to_i())
    erb(:Book)
  end
  
  # post a new Book. After the Book is added, sinatra will route to the view for the author the Book belongs to
  post('/authors/:id/Books') do
    @author = Author.find(params[:id].to_i())
    Book = Book.new({:name => params[:Book_name], :album_id => @author.id, :id => nil})
    Book.save()
    erb(:author)
  end
  
  # edit a Book & then route back to the author view
  patch('/authors/:id/Books/:book_id') do
    @author = Author.find(params[:id].to_i())
    Book = Book.find(params[:book_id].to_i())
    Book.update(params[:name], @author.id)
    erb(:author)
  end
  
  # delete a Book & then route back to the author view
  delete('/authors/:id/Books/:book_id') do
    Book = Book.find(params[:book_id].to_i())
    Book.delete()
    @author = Author.find(params[:id].to_())
    erb(:author)
  end
  
  # ------ Search route -------
  
  # display search results page
  get('/results') do
    erb(:search_results)
  end
  
  # display results
  post('/results') do
    erb(:search_results)
  end
  
  # ------- artist route -------
  
  # get a list of all artists
  get('/artists') do
    @artists = artist.all
    erb(:artists)
  end
  
  # add a new artist
  get('/artists/new') do
    erb(:new_artist)
  end
  
  # look at the detail page for a single author
  get('/artists/:id') do
    @artist = artist.find(params[:id].to_i())
    erb(:artist)
  end

  # add a new author to the list of artists
post('/artists') do
    name = params[:artist_name]
    artist = artist.new({:name => name, :id => nil})
    artist.save()
    redirect to('/artists')
  end
  
  # update a single author
  patch('/artists/:id') do
    @artist = artist.find(params[:id].to_i())
    @artist.update(:name => params[:name], :author_name => params[:author_name])
    redirect to('/artists')
  end
  
  # delete an author from list
  delete('/artists/:id') do
    @artist = artist.find(params[:id].to_i())
    @artist.delete()
    redirect to('/artists')
  end

  # Get the detail for a specific Book such as lyrics and Bookwriters.
get('/authors/:id/Books/:book_id') do
    @Book = Book.find(params[:book_id].to_i())
    erb(:Book)
  end
  
  # Post a new Book. After the Book is added, Sinatra will route to the view for the author the Book belongs to.
  post('/authors/:id/Books') do
    @author = Author.find(params[:id].to_i())
    Book = Book.new({:name => params[:Book_name],:album_id => @author.id,:id => nil})
    Book.save()
    erb(:author)
  end
  
  # Edit a Book and then route back to the author view.
  patch('/authors/:id/Books/:book_id') do
    @author = Author.find(params[:id].to_i())
    Book = Book.find(params[:book_id].to_i())
    Book.update(params[:name], @author.id)
    erb(:author)
  end
  
  # Delete a Book and then route back to the author view.
  delete('/authors/:id/Books/:book_id') do
    Book = Book.find(params[:book_id].to_i())
    Book.delete
    @author = Author.find(params[:id].to_i())
    erb(:author)
  end