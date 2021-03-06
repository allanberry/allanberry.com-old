class Work
  attr_accessor :id, :title, :synopsis

  def initialize(yaml_)

    #symbols
    # id must exist
    begin
      @id = yaml_["id"].to_sym
    rescue
      begin
        @id = yaml_["title"].to_sym
      rescue
        @id = :undefined
      end
      @id
    end

    #strings
    @title  = yaml_["title"]
    @synopsis = yaml_["synopsis"]
    @note   = yaml_["note"]
    @format = yaml_["format"]
    @categories = yaml_["categories"] || "other"
    @keywords = yaml_["keywords"]

    #yaml data still
    @yaml_dates  = yaml_["dates"]
    @yaml_images = yaml_["images"]
    @yaml_media = yaml_["media"]


    if @yaml_images
      @image = "img/260x260/" << yaml_["images"][0]["img_filename"]
    else
      @image = "img/260x260/img_tmp_h.jpg"
    end
  end

  def images_with_aspects
    @yaml_images
  end


  def image_url(size_)
    default = "img/260x260/img_tmp_h.jpg"
    # make sure size_ is one we carry
    ok_sizes = [160, 260, 640, 1600]

    # make sure images exist, and if the supplied size is correct 
    if size_ == '640crop'
      image = "/img/" << size_ << "/" << @yaml_images[0]["img_filename"]
    elsif @yaml_images && ok_sizes.include?(size_.to_i)
      image = "/img/" << size_ << "x" << size_ << "/" << @yaml_images[0]["img_filename"]
    else
      image = default
    end
    image
  end

  def image_urls(size_)
    output = []
    @yaml_images.each do |i|
      output << "/img/640x640/" + i['img_filename']
    end
    output
  end

  def years
    year_array = []
    @yaml_dates.each do |y|
      d = y['date'].to_s
      year_array << d[0..3].to_i
    end
    return year_array
  end

  def categories
    cats = @categories.split(',')
    cats.map! do |c|
      c = c.strip.gsub(/\s+/, "_").downcase.to_sym
    end
  end

  def keywords
    keys = @keywords.split(',')
    keys.map! do |k|
      k = k.strip.gsub(/\s+/, "_").downcase.to_sym
    end
  end

  def date
    if years.size == 0
      return 'undated'
    elsif years.size == 1
      return years[0].to_s
    else
      return years.min.to_s << "–" << years.max.to_s
    end
  end

  def notes
    @note.split("\n")
  end

  def media
    output = []
    @yaml_media.each do |m|
      output << m["medium"]
    end
    output
  end

end