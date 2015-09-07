require 'rubygems'
require 'sinatra'

get '/' do
  "Hello, World!"
end

get '/about' do
  'A little about me.'
end
get '/hello/:name' do
  params[:name]
end
get '/hello/:name/:city' do
  "Hey there #{params[:name]} from #{params[:city]}."
end

get '/more/*' do
  params[:splat]
end

get '/form' do
  erb :form
end

post '/form' do
  "You said '#{params[:message]}'"
end

get '/secret' do
  erb :secret
end

post '/secret' do
  params[:secret].reverse
end

get '/decrypt/:secret' do
  params[:secret].reverse
end
not_found do
  status 404
  'not found'
end
=begin
#Refactored version of the not found route
not_found do
  halt 404, 'page not found'
end
=end