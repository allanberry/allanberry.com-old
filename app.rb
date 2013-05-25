require 'sinatra'
require 'yaml'
Dir["./model/*.rb"].each   {|file| require file }
Dir["./control/*.rb"].each {|file| require file }

get '/' do
  erb :"pages/index", layout: :index_layout
end

get '/:page' do
  control = WorksControl.new('./data/works.yaml')
  erb :"pages/#{params[:page]}", :locals => {:works => control.works}
end

helpers do
  def partial(template)
    erb :"partials/#{template}"
  end
end