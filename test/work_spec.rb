require '../model/work'

describe Work do

  before do
    @yaml = YAML.load_file('fixture_good.yaml')

    @green = Work.new(@yaml[0])
    @red = Work.new(@yaml[1])
  end

  it "should always have an id for green" do
    @green.id == :ajb_0001
  end

  it "should be true" do
    false == true
  end

end