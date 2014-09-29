require 'RMagick'
include Magick

class SignTool

  def initialize(sign,gravity,padding)
   @sign,@gravity,@padding = sign,gravity,padding
  end

  def sign_files(files)
    text = initialize_text
    files.each do |file|
      sign_file(text,file)
    end
  end

private 
  def initialize_text
    text = Magick::Draw.new
    text.font_family = 'helvetica'
    text.pointsize = 40
    text.gravity = @gravity
    text
  end

  def sign_file(text,file)
    canvas = ImageList.new(file)
    text.annotate(canvas, 0,0,2 + @padding,2 + @padding, @sign)       {self.fill  = 'gray83' }
    text.annotate(canvas, 0,0,-1.5 + @padding,-1.5 + @padding, @sign) {self.fill  = 'gray40' }
    text.annotate(canvas, 0,0,@padding,@padding, @sign)       {self.fill  = 'darkred'}
    
    save_file(file,canvas)
  end

  def save_file(file,canvas)
    new_file_name = file.sub(File.dirname(file),"signed")
    new_dir_name = File.dirname(new_file_name)
    Dir.mkdir(new_dir_name) unless Dir.exists?(new_dir_name)

    canvas.write(new_file_name)
  end
end