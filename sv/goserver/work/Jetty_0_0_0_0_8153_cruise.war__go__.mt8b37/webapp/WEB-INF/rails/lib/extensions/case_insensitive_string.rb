com.thoughtworks.cruise.config.CaseInsensitiveString.class_eval do
  def method_missing method, *args
    self.toString().to_s.send(method, *args)
  end

  def to_s
    self.toString() || ""
  end
end