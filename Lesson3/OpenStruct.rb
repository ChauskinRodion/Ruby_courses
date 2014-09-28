class OpenStruct
  def initialize(hash)
    raise "constructor parameter must be a Hash object" unless hash.class == Hash
    @hash = hash
    @hash.each do |key, value|
	      self.define_singleton_method(key) {@hash[key]} 
	      self.define_singleton_method("#{key}=") {|value| @hash[key] = value} 
    end
  end
end

hash = {a:2, b:2, :key => "value", :s=>3}

os = OpenStruct.new(hash)
os.a = "aaa"
hash[:b] = "new_b"
hash.each {|key,value| puts "OpenStruct.#{key}: #{os.send(key)} Hash[#{key}]: #{hash[key]}"}
