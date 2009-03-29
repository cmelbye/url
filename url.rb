require 'rubygems'
require 'sinatra'
require 'models'
get '/' do
  @urls = Url.find(:all, :limit => 5)
  erb :index
end
post '/' do
  return unless params[:url]
  params[:url].replace("http://" + params[:url]) if not params[:url] =~ /^(https?)/
  @url = Url.create( :url => params[:url], :note => params[:note] )
  erb :saved
end
get '/:code' do
  return unless params[:code]
  @url = Url.find_by_code(params[:code])
  redirect('/') if @url.nil?
  redirect(@url.url) if @url.note.empty?
  erb :note
end
get '/p/:code' do
  return unless params[:code]
  @url = Url.find_by_code(params[:code])
  erb :preview
end