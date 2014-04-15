module Admin
  module MaterialHelper
    include JavaImports

    def material_options
      {l.string("SUBVERSION") => SvnMaterialConfig::TYPE,
       l.string("GIT") => GitMaterialConfig::TYPE,
       l.string("MERCURIAL") => HgMaterialConfig::TYPE,
       l.string("P4") => P4MaterialConfig::TYPE,
       l.string("TFS") => com.thoughtworks.cruise.config.materials.tfs.TfsMaterialConfig::TYPE,
       l.string("PIPELINE") => DependencyMaterialConfig::TYPE,
       l.string("PACKAGE") => PackageMaterialConfig::TYPE
      }
    end

    def repository_packages_map_from_config
      return @repository_packages_map if @repository_packages_map
      @repository_packages_map = {}
      @original_cruise_config.getPackageRepositories().each do |repo|
        metadata = RepositoryMetadataStore.getInstance().getMetadata(repo.getPluginConfiguration().getId())
        hash = {:name => repo.getName(), :packages => [], :is_plugin_missing => metadata.nil?, :plugin_id => repo.getPluginConfiguration().getId()}
        repo.getPackages().each do |package|
          hash[:packages] << {:name => package.getName(), :id => package.getId()}
        end
        @repository_packages_map[repo.getId()] = hash
      end
      @repository_packages_map
    end

    def package_material_plugins
      plugins = RepositoryMetadataStore.getInstance().getPlugins()
      [["[Select]", ""]] + plugins.to_a
    end
  end
end