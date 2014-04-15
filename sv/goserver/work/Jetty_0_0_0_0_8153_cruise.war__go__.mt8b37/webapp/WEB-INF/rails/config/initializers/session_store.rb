# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_untitled1_session',
  :secret      => 'd13d641a5986226b6e4762359d3386819ddd3b74efac5f8bb9107db89348676ba8502993765fd27807794cb3c2bd17f9fe052fb2755479f616361a8c1b3c4321'
}

# Use the same session store as Java. This is what makes us see the authentication context from Spring for example.
if defined?($servlet_context)
  require 'action_controller/session/java_servlet_store'
  ActionController::Base.session_store = :java_servlet_store
end
