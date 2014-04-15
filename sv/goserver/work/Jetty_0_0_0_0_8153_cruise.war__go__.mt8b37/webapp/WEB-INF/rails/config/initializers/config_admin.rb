unless RAILS_ENV == 'development' or RAILS_ENV == 'test'
  Dir.glob(File.join(RAILS_ROOT, "lib", "config_update", "*.rb")).each do |recipe|
    require recipe
  end
end