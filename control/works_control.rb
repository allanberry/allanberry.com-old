class WorksControl
  @@categories = {
    :art => [
      :kill_them_all,
      :voronoi_bubbles,
      :shard,
      :swerve,
      :watertowers],
    :design => [
      :healthy_ringing,
      :connchem,
      :brooklyn_tablet],
    :preservation => [
      :healthy_ringing,
      :connchem,
      :brooklyn_tablet]}

  def initialize
    @yaml = YAML.load_file('./data/works.yaml')

    # initialize works
    @works = []
    @yaml["works"].each do |w|
      @works << Work.new(w)
    end
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
end