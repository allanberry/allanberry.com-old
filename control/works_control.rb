class WorksControl
  attr_accessor :works

  @@works_art = [:kill_them_all, :voronoi_bubbles, :shard, :swerve]
  @@works_design = [:healthy_ringing]
  @@works_preservation = [:gordon]

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
    @yaml["works"].each do |w|
      @works << Work.new(w)
    end

    ###
    #puts @works[0].id
    #@works
    ###
  end

  def get_works_by_category(cat_)
    cat = cat_.to_sym
    @yaml["works"].each do |w|
      if @@categories[cat].include?(w['id'].to_sym )
        @works << Work.new(w)
      end
    end
  end

  def get_work_by_id(id_)
    hash = @yaml['works'].find do |item|
      item['id'] == id_
    end
    Work.new(hash)
  end
end