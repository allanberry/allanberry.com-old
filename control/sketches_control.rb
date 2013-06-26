class SketchControl
  attr_accessor :p5_files

  def initialize(sketch_name_)
    @sketch_name = sketch_name_
  end

  def p5_files # p5 files in the sketchbook/sketch_name directory
    output = Array.new 
    Dir.entries('./public/p5/' + @sketch_name.to_s).each do |file|
      next if ['..', '.', '.DS_Store'].include? file
      if file =~ /.pde$/ # check if file is p5
        output << ( '/p5/' + @sketch_name.to_s + '/' + file )
      end
    end
    output
  end

end