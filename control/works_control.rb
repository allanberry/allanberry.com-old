class WorksControl
  @@works_art = [:kill_them_all, :voronoi_bubbles, :shard, :swerve, :watertowers]
  @@works_design = [:healthy_ringing, :connchem, :brooklyn_tablet]
  @@works_preservation = [:gordon, :watertowers, :chicago_maps]

  @@categories = {
    :art => @@works_art,
    :design => @@works_design,
    :preservation => @@works_preservation
  }


  def initialize
    @works = Array.new
    @yaml = YAML.load_file('./data/works.yaml')
  end

  def get_works_all
    array = []
    @yaml["works"].each do |w|
      array << Work.new(w)
    end

    array.sort {|a,b| a.date_completed <=> b.date_completed }.reverse
  end

  def get_works_by_category(cat_)
    cat = cat_.to_sym
    get_works_all do |w|
      if @@categories[cat].include?(w['id'].to_sym )
        @works << Work.new(w)
      end
    end
  end

  def get_work_by_id(id_)
    hash = @yaml['works'].find do |w|
      w['id'] == id_
    end
    Work.new(hash)
  end
end