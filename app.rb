require 'sinatra'
require 'yaml'
Dir["./model/*.rb"].each   {|file| require file }
Dir["./control/*.rb"].each {|file| require file }

get '/' do
  erb :"pages/index", layout: :index_layout
end

get '/works/:work' do
  control = WorksControl.new
  work = control.get_work_by_id("#{params[:work]}")
  erb :"pages/work", :locals => {:work => work}
end

get '/:page' do
  control = WorksControl.new
  control.get_works_all
  erb :"pages/#{params[:page]}", :locals => {:works => control.works}
end

helpers do
  def partial(template)
    erb :"partials/#{template}"
  end
end