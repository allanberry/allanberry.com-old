class Work
  attr_accessor :id, :title, :slug

  def initialize(yaml_)

    @id     = yaml_["id"]
    @title  = yaml_["title"]
    @slug   = yaml_["slug"]
    @images = yaml_["images"]
    @dates  = yaml_["dates"]
    @note   = yaml_["note"]
    @media = yaml_["media"]

    if @images
      @image = "img/260x260/" << yaml_["images"][0]["img_filename"]
    else
      @image = "img/260x260/img_tmp_h.jpg"
    end
  end


  def image(size_)
    default = "img/260x260/img_tmp_h.jpg"
    # make sure size_ is one we carry
    ok_sizes = [160, 260, 640, 1600]

    # make sure images exist, and if the supplied size is correct 
    if @images && ok_sizes.include?(size_.to_i)
      image = "/img/" << size_ << "x" << size_ << "/" << @images[0]["img_filename"]
    else
      image = default
    end
    image
  end

  def images(size_)
    array = []
    @images.each do |i|
      array << "/img/260x260/" + i['img_filename']
    end
    array
  end

  def date
    if @dates.length == 1
      @dates[0]['date'].to_s[0..3]
    elsif @dates.length > 1
      @dates.sort_by! { |hsh| hsh["date"] }
      @dates[0]['date'].to_s[0..3] << "–" << @dates[-1]['date'].to_s[0..3]
    else
      'undated'
    end
  end

  def date_completed
    date[-4..-1].to_i
  end

  def notes
    @note.split("\n")
  end

  def media
    array = []
    @media.each do |m|
      array << m["medium"]
    end
    array
  end

end