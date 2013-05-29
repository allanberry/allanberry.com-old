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
  pages_works  = [:works, :art, :design, :preservation] 
  pages_static = [:about, :contact, :index]
  pages_all    = pages_works + pages_static

  if pages_works.include?(params[:page].to_sym)
    control = WorksControl.new
    if params[:page] == 'works'
      control.get_works_all
    else
      control.get_works_by_category(params[:page])
    end
    return erb :"pages/#{params[:page]}", :locals => {:works => control.get_works_all}
  elsif pages_static.include?(params[:page].to_sym)
    return erb :"pages/#{params[:page]}"
  else
    file_not_found
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