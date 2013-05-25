class WorksControl
  attr_accessor :works

  def initialize(yaml_)

    @works = Array.new

    yaml = open(yaml_) { |f| YAML.load(f) }
    yaml_array = yaml["works"]

    yaml_array.each do |w|
      @works << Work.new(w)
    end


  end
end