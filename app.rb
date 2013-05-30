require 'sinatra'
require 'yaml'
require 'chronic'
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
  # only use symbols to pass values
  page = params[:page].to_sym
  # router: static pages first, then dynamic, then unknown
  if [:about, :contact, :index].include?(page)
    erb :"pages/#{params[:page]}"
  elsif [:works, :art, :design, :preservation].include?(page)
    control = WorksControl.new
    erb :"pages/#{params[:page]}", :locals => {:works => control.get_works_by_category(page)}
  else
    return file_not_found
  end
end

get '*' do
  file_not_found
end

helpers do
  def partial(template)
    erb :"partials/#{template}"
  end
end

def file_not_found
  erb :"pages/404"
end