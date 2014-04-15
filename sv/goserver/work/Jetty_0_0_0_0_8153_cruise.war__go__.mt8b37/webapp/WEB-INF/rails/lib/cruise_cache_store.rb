class CruiseCacheStore < ActiveSupport::Cache::Store
  def read(name, options = nil)
    super
    cache.get(*key(name, options))
  end

  def write(name, value, options = nil)
    super
    cache.put(*(key(name, options) << value))
  end

  def delete(name, options = nil)
    super
    value = cache.get(*key(name, options))
    cache.remove(*key(name, options))
    value
  end

  def delete_matched(matcher, options = nil)
    raise "unsupported operation delete_matched"
  end

  def exist?(name, options = nil)
    super
    !!cache.get(*key(name, options))
  end

  def clear
    cache.clear
  end

  private
  def cache
    @cache ||= Spring.bean("cruiseCache")
  end

  def key(name, options)
    (options && options.has_key?(:subkey)) ? [name, options[:subkey]] : [name]
  end
end