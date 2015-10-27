# Be sure to restart your server when you modify this file.

FasterNotes::Application.config.session_store SmartSession::Store, key: '_faster_notes_session'

#FasterNotes::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# FasterNotes::Application.config.session_store :active_record_store

