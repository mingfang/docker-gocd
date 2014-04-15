unless ActiveSupport::Cache.respond_to?(:expand_cache_key_without_namespace_killing)
  module ActiveSupport::Cache
    class << self
      def expand_cache_key_with_namespace_killing(key, namespace = nil)
        expand_cache_key_without_namespace_killing(key)
      end

      alias_method_chain :expand_cache_key, :namespace_killing
    end
  end
end