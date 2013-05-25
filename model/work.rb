class Work
  attr_accessor :id, :title, :image

  def initialize(yaml_)
    @id     = yaml_["id"]
    @title  = yaml_["title"]
    @images = yaml_["images"]

    if @images
      @image = "img/260x260/" << yaml_["images"][0]["img_filename"]
    else
      @image = "img/260x260/img_tmp_h.jpg"
    end
  end
end