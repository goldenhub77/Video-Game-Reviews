class ReviewDecanter < Decanter::Base
  strict true
  input :title, :string
  input :review, :string
  input :rating, :integer
  input :video_game_id, :integer
  input :platforms, :platform_array
end
