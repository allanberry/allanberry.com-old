class WorksControl

  # Categories are a flat structure, determined (and enforced) from a controlled vocabulary, defined below, and keyed in the YAML file
  # Keywords are a free tagging structure from the YAML file

  @@categories  = [
    :art,
    :illustration,
    :design,
    :collections,
    :software,
      :systems,
      :books,
      :data_visualization,
      :documentation,
      :graphics,
      :interfaces,
      :painting,
      :photography,
      :preservation,
      :sculpture,
      :websites,
      :writing,
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
    if @@categories.include? cat_
      @works.each do |w|
        if w.categories.include? cat_
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