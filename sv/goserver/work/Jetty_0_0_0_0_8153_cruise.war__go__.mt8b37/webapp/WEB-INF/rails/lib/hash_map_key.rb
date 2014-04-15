class HashMapKey
  SEPERATOR = '<|>'
  ESCAPED_SEPERATOR = '<<|>>'

  attr_reader :key, :is_string, :key_as_str

  def initialize key
    @key = key
    @key_as_str = @key.to_s
    @is_string = (@key_as_str == @key)
  end

  def <=> other
    if (!(@is_string ^ other.is_string))
      return @key_as_str <=> other.key_as_str
    end
    return @is_string ? -1 : 1
  end

  def == other
    @key == other.key
  end

  def self.replace_special_chars str
    str.gsub('-', '--').gsub(SEPERATOR, ESCAPED_SEPERATOR)
  end

  def self.hypen_safe_key_for(hash_or_object)
    hash = to_hash(hash_or_object)
    buffer = java.lang.StringBuilder.new
    hash.keys.map{|k| HashMapKey.new(k) }.sort.each do |key|
      buffer.append(replace_special_chars(key.key_as_str)).append(SEPERATOR).append(replace_special_chars(hash[key.key].to_s))
    end
    buffer.to_s
  end

  def self.to_hash(object)
    object.respond_to?(:has_key?) ? object : {:object_type => object.class, :object_id => object.id} 
  end
end

