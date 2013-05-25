require 'sinatra'
require 'yaml'
require './control/work'

$works = Array.new

get '/' do
  erb :"pages/index", layout: :index_layout
end

get '/:page' do
  $works = load_works

  erb :"pages/#{params[:page]}"
end

helpers do
  def partial(template)
    erb :"partials/#{template}"
  end
end

def load_works
  yaml = open('./model/works.yaml') { |f| YAML.load(f) }
  works = yaml["works"]

  works.each do |w|
    $works << Work.new(w)
  end

  $works
end