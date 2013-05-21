require 'sinatra'

get '/' do
  erb :"pages/index", layout: :index_layout
end

get '/:page' do
  erb :"pages/#{params[:page]}"
end

helpers do
  def partial(template)
    erb :"partials/#{template}"
  end
end