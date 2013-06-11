# just a test file, to get used to BDD

describe Hash do
  before do
    @hash = Hash.new
    @hash[:hello] = 'world'
  end

  it "should return a blank instance" do
    Hash.new.should == {}
  end

  it "hash the correct information in a key" do
    @hash[:hello].should == 'world'
  end  
end