# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )

#resets platform and genre constants
if ActiveRecord::Base.connection.data_source_exists? 'genres'
  Genre.destroy_all
  ActiveRecord::Base.connection.reset_pk_sequence!('genres')

  VideoGame::GENRES.each do |genre|
    Genre.find_or_create_by(name: genre[:name], abbr: genre[:abbr])
  end
end
if ActiveRecord::Base.connection.data_source_exists? 'platforms'
  Platform.destroy_all
  ActiveRecord::Base.connection.reset_pk_sequence!('platforms')
  VideoGame::PLATFORMS.each do |platform|
    Platform.find_or_create_by(name: platform[:name])
  end
end
