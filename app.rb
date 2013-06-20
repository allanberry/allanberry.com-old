require 'sinatra'
require 'yaml'
require 'chronic'

# gimme some pages to load
Dir["./model/*.rb"].each   {|file| require file }
Dir["./control/*.rb"].each {|file| require file }

# got links to former drupal site? TODO: expand me.
old_site_map = {
  "/work/connected-chemistry-curriculum" => "/works/connchem",
  "/content/icosahedra-tessellations" => "/works/icosahedra"
}

# LAYOUTS
# :layout has a sidebar
# :index_layout has no sidebar
# :sketch_layout is very minimal


get '/' do
  erb :"pages/index", layout: :index_layout
end


get '/sketches/:sketch/?' do
  control = SketchControl.new # a Ruby sidecar, to feed variables to the sketch, etc.

  # get sketches
  all_sketches = Array.new
  Dir.entries("./public/sketchbook").each do |file|
    next if [".", "..", ".DS_Store"].include?(file) # ignore system files
    all_sketches << file.to_sym
  end

  if all_sketches.include?(params[:sketch].to_sym) 
    erb :"sketches/#{params[:sketch]}", layout: :sketch_layout, :locals => {:control => control}
  # TODO currently, this code requires both a sketch folder, a sketch PDE, and a sketch ERB.
  # I'd like to create a default sketch ERB file, for sketches which don't need the overhead
  # of an entire ERB file to themselves:
  # elsif
  else
    file_not_found
  end
end


get '/works/:work/?' do
  control = WorksControl.new
  work = control.get_work_by_id("#{params[:work]}")
  erb :"pages/work", :locals => {:work => work}
end


get '/:page/?' do
  # only use symbols to pass values
  page = params[:page].to_sym
  # router: static pages first, then dynamic, then unknown
  if [:about, :contact, :index, :copyright].include?(page)
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