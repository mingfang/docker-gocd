java.util.Map.class_eval do

  def to_hash
    hash = {}
    entrySet().each do |entry|
      hash[entry.getKey()] = entry.getValue()
    end
    hash
  end
end
