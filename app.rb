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
  "/content/icosahedra-tessellations" => "/works/icosahedra",
  "/preservation" => "/collections"
}

# LAYOUTS
# :layout has a sidebar
# :layout_index has no sidebar
# :layout_sketch is very minimal

get '/' do
  erb :"pages/index", layout: :layout_index
end

get '/works/:work/?' do
  works_control = WorksControl.new
  work = works_control.get_work_by_id("#{params[:work]}")
  erb :"pages/work", :locals => {:work => work}
end

# gimme a list of sketches
def sketches
  output = Array.new
  sketches_dir = "./views/pages/sketches/"
  names_in_dir(sketches_dir)
end

get '/sketches/:sketch/?' do
  if sketches.include? :"#{params[:sketch]}"
    erb :"pages/sketches/#{params[:sketch]}"
  else
    file_not_found
  end
end

get '/:page/?' do
  works_control = WorksControl.new

  # stock pages array
  pages = []
  pages_dir = "./views/pages/"
  names_in_dir(pages_dir).each do |p|
    pages << p
  end

  # only use symbols to pass values
  page_name = params[:page].to_sym

  # predefined pages
  if pages.include?(page_name)
    works = works_control.get_works_by_category(page_name) ||
            works_control.get_works_by_keyword(page_name)
    erb :"pages/#{params[:page]}", locals: { works: works }

  # auto-generated pages
  elsif works_control.get_works_by_keyword(page_name)
    works = works_control.get_works_by_keyword(page_name)
    erb :"pages/keyword_page", locals: { works: works, keyword: page_name}
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

def names_in_dir(dir)
  output = []
  Dir.foreach(dir) do |file|
    next if [".","..",".DS_Store"].include? file
    output << File.basename(file, ".erb").to_s.to_sym
  end
  return output
end

def file_not_found
  erb :"pages/404"
end