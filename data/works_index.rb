class WorksIndex
  attr_accessor :categories, :keywords

  @categories = []
  @keywords = []

  # Categories are a flat structure, determined (and enforced) from a controlled vocabulary, defined below, and keyed in the YAML file
  # Keywords are a free tagging structure from the YAML file
  def initialize
    @categories  = [
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

    @keywords = []

    # fill keywords
    @works.each { |w| @index.keywords.concat(w.keywords) }
    @index.keywords.sort!.uniq!
  end
end