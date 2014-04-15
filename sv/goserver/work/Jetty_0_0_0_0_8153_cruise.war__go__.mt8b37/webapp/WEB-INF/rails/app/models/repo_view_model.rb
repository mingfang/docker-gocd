class RepoViewModel
  attr_accessor :properties, :errors
  include RailsLocalizer

  def initialize(metadata, repository, plugin_id)
    @properties = []
    @errors = com.thoughtworks.cruise.domain.ConfigErrors.new
    unless metadata
      @errors.add("pluginId", l.string("ASSOCIATED_PLUGIN_NOT_FOUND", [plugin_id].to_java(java.lang.String)))
      return
    end

    package_configurations = metadata.list()
    package_configurations.each do |config|
      property = nil
      if repository
        property = repository.getConfiguration().getProperty(config.getKey())
      end
      @properties << PackagePropertyModel.new(config, property)
    end
  end
end

