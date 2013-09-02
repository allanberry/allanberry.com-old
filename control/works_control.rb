class WorksControl

  # Categories are a hierarchical structure, entirely determined here a priori.
  # Types are a flat structure, determined (and enforced) from a controlled vocabulary, defined below, and keyed in the YAML file
  # Keywords are a free tagging structure from the YAML file
  @@categories = {
    :art => [
      :credit_card_paintings,
      :dystopia,
      :godbaby,
      :hemingway,
      :hexagon_tiles,
      :icosahedra_tessellations,
      :kill_them_all,
      :magnet_icosahedron,
      :mannequin,
      :pondfairy,
      :red_tessellation,
      :shard,
      :struts,
      :swerve,
      :taube,
      :voronoi_bubbles,
      :wash,
      :watertowers
      ],
    :design => [
      #:ajb_website,
      #:cities_at_war,
      :age_gdp_v11n,
      :ahgsa_website,
      :bell_family,
      :brooklyn_tablet,
      :connchem,
      :expensive_paint,
      :gordon,
      :healthy_ringing,
      :hex_land,
      :icosahedra_tessellations,
      :pondfairy,
      :shirt_designs,
      :mucha
      ],
    :preservation => [
      :age_gdp_v11n,
      :art_collection_dbs,
      :brooklyn_tablet,
      :chicago_maps,
      :erd,
      :expensive_paint,
      :gordon,
      :linux_infopack,
      :spurlock,
      :workflow_diagrams,
      ]
    }

  @@types  = [
    :art,
    :illustration,
    :collections,
    :design,
      :software,
      :preservation,
      :painting,
      :collections,
      :books,
      :data_visualization,
      :interfaces,
      :graphics,
      :photography,
      :sculpture,
      :systems,
      :websites,
      :writing,
      :documentation
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