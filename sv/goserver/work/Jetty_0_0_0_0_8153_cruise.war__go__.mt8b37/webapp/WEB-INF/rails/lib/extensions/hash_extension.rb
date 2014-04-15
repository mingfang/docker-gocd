Hash.class_eval do
  def only *keys
    sub_hash = self.class.new
    keys.each do |sub_key|
      self.include?(sub_key) && sub_hash[sub_key] = self[sub_key]
    end
    sub_hash
  end
end
