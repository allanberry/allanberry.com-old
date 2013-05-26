class WorksControl
  attr_accessor :works

  works_art = [:kill_them_all, :voronoi_bubbles, :shard, :swerve]
  works_design = [:healthy_ringing]
  works_preservation = [:gordon]


  def initialize
    @works = Array.new
    @yaml = YAML.load_file('./data/works.yaml')
  end

  def get_works_all
    @yaml["works"].each do |w|
      @works << Work.new(w)
    end
  end

  def get_works_art
    @yaml["works"].each do |w|
      puts w.id
      @works << Work.new(w)
    end
  end

  def get_works_design
  end

  def get_works_preservation
  end

  def get_work_by_id(id_)
    hash = @yaml['works'].find do |item|
      item['id'] == id_
    end
    Work.new(hash)
  end
end