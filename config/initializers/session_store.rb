require 'mongo_rails_store'

Collaboration::Application.config.session_store :mongo_rails_store, :key => '_collaboration_session', :database => Mongoid.database

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Collaboration::Application.config.session_store :active_record_store
