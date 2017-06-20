class VideoGameDecanter < Decanter::Base
  strict true
  input :id, :integer
  input :title, :capitalize
  input :developer, :capitalize
  input :description, :string
  input :genre_id, :integer
  input :release_date, :string_to_date
  input :rating, :integer
  input :platforms, :platform_array
end
