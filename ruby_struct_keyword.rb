class Object
  def struct(name, &blk)
    @properties = []
    def property(name)
      @properties << name
    end
    location = caller(1..1).first

    line_content = if location.include?('(irb)')
                     IRB.CurrentContext.io.line(-1).chomp
                   else
                     # For non-IRB usage, fall back to file reading
                     file, line_number = location.split(':')[0..1]

                     # Read the file to get the content of the specific line
                     File.readlines(file)[line_number.to_i - 1].strip
                   end
    const_sym = line_content.split(' ')[1].to_sym
    instance_exec(&blk)
    if self.class == Object
      self.class.const_set(const_sym, Struct.new(*@properties))
    else
      self.const_set(const_sym, Struct.new(*@properties))
    end
    
  end

  def self.const_missing(name)
    # Get the location of the constant reference
    location = caller(1..1).first

    line_content = if location.include?('(irb)')
                     IRB.CurrentContext.io.line(-1).chomp
                   else
                     # For non-IRB usage, fall back to file reading
                     file, line_number = location.split(':')[0..1]

                     # Read the file to get the content of the specific line
                     File.readlines(file)[line_number.to_i - 1].strip
                   end

    # Optionally, raise an error or define the constant
    super unless line_content.start_with?('struct ')
  end
end
class Test
  struct User do
    property :name
  end
end

struct Userex do
  property :name
end