Dir.glob(File.join(RAILS_ROOT, 'lib', 'extensions', '*.rb')).each do |extension_path|
  load extension_path
end
