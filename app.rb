require 'sinatra'
require 'chronic'
require 'pathname'
require 'yaml'

models_dir   = "./model/*.rb"
controls_dir = "./control/*.rb"

# gimme some pages to load
Dir[models_dir].each   {|file| require file }
Dir[controls_dir].each {|file| require file }

# got links to former drupal site? TODO: expand me.
old_site_map = {
  "/work/connected-chemistry-curriculum" => "/works/connchem",
  "/content/icosahedra-tessellations" => "/works/icosahedra"
}

# LAYOUTS
# :layout has a sidebar
# :layout_index has no sidebar
# :layout_sketch is very minimal

get '/' do
  erb :"pages/index", layout: :layout_index
end

get '/works/:work/?' do
  control = WorksControl.new
  work = control.get_work_by_id("#{params[:work]}")
  erb :"pages/work", :locals => {:work => work}
end

# gimme a list of sketches
def sketches
  output = Array.new
  sketches_dir = "./views/pages/sketches/"
  Dir.foreach(sketches_dir) do |file|
    next if [".","..",".DS_Store"].include? file
    output << File.basename(file, ".erb").to_s.to_sym
  end
  output
end

get '/sketches/:sketch/?' do
  if sketches.include? :"#{params[:sketch]}"
    erb :"pages/sketches/#{params[:sketch]}"
  else
    file_not_found
  end
end

get '/:page/?' do
  basic_pages = [:about, :contact, :index, :copyright, :sketches]
  works_pages = [:works, :art, :design, :preservation]

  # only use symbols to pass values
  page_name = params[:page].to_sym

  # pages
  if basic_pages.include?(page_name)
    erb :"pages/#{params[:page]}"

  # portfolio
  elsif works_pages.include?(page_name)
    control = WorksControl.new
    erb :"pages/#{params[:page]}", :locals => {:works => control.get_works_by_category(page_name)}

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