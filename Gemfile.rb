source 'https://rubygems.org'
# --- ask what line 3 does ---
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.10'

gem('sinatra')
gem('sinatra-contrib')
gem('rspec')
gem('capybara')
gem('pry')
gem('pg')