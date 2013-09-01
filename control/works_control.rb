class WorksControl

  # Categories are a hierarchical structure, entirely determined here a priori.
  # Types are a flat structure, determined (and enforced) from a controlled vocabulary, defined below, and keyed in the YAML file
  # Keywords are a free tagging structure from the YAML file
  @@categories = {
    :art => [
      :kill_them_all,
      :voronoi_bubbles,
      :shard,
      :swerve,
      :watertowers,
      :icosahedra_tessellations,
      :pondfairy,
      :credit_card_paintings,
      :dystopia,
      :red_tessellation,
      :mannequin,
      :taube,
      :magnet_icosahedron,
      :hexagon_tiles,
      :struts,
      :wash,
      :hemingway,
      :godbaby],
    :design => [
      :gordon,
      :healthy_ringing,
      :connchem,
      :brooklyn_tablet,
      :ahgsa_website,
      #:ajb_website,
      #:cities_at_war,
      :expensive_paint,
      :age_gdp_v11n,
      :hex_land,
      :icosahedra_tessellations,
      :bell_family,
      :pondfairy,
      :shirt_designs],
    :preservation => [
      :linux_infopack,
      :erd,
      :expensive_paint,
      :age_gdp_v11n,
      :workflow_diagrams,
      :spurlock,
      :art_collection_dbs,
      :gordon,
      :brooklyn_tablet,
      :chicago_maps]}

  @@types  = [
    :books,
    :collections,
    :data_visualization,
    :documentation,
    :graphics,
    :illustration,
    :interfaces,
    :painting,
    :photography,
    :software,
    :sculpture,
    :systems,
    :websites,
    :writing
  ]

  @@keywords = []


  def initialize
    @yaml = YAML.load_file('./data/works.yaml')

    # initialize works
    @works = []
    @yaml["works"].each do |w|
      @works << Work.new(w)
    end

    # fill global keywords array
    @works.each { |w| @@keywords.concat(w.keywords) }
    @@keywords.sort!.uniq!

    #test
    puts "---"
    puts get_works_by_keyword(:print)
  end

  def get_work_by_id(id_)
    @works.find { |x| x.id.to_sym == id_.to_sym }
  end

  def get_works_by_category(cat_)
    output = []
    if @@categories.has_key? cat_
      @@categories[cat_].each do |sym|
        output << get_work_by_id(sym)
      end
      return output
    elsif cat_ == :works
      return @works
    else
      return []
    end
  end

  def get_works_by_type(type_)
    output = []
    if @@types.include? type_
      @works.each do |w|
        if w.types.include? type_
          output << w
        end
      end
      return output
    else
      return []
    end
  end

  def get_works_by_keyword(key_)
    output = []
    if @@keywords.include? key_
      @works.each do |w|
        if w.keywords.include? key_
          output << w
        end
      end
      return output
    else
      return []
    end
  end

end