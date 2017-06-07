// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function setRating() {
  $input_value = $("#video_game_rating").val();
  $label = $("#video_game_rating").siblings("label");
  $label.text("(0 worst - 5 best) Rating: " + $input_value);
}

$(document).ready(function() {
  setRating();
  $("#video_game_rating").on("mousemove keyup", setRating);
})
