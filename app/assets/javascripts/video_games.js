// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$("#new_video_game").change(function() {
  $form = $(this);
  $input_value = $form.children("#video_game_rating").val();
  $label = $form.children("#video_game_rating").siblings("label");
  $label.text("Current Value = " + $input_value);
})
