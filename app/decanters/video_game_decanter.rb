class VideoGameDecanter < Decanter::Base
  strict true
  
  input :title, :string
  input :developer, :string
  input :description, :string
  input :genre_id, :integer
  input :release_date, :string_to_date
  input :rating, :integer
  input :platforms, :platform_array
end
