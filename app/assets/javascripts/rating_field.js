// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function setRating() {
  $inputValue = $(".range-field").val();
  $label = $(".range-field").siblings("label");
  $label.text("(1 worst - 5 best) Rating: " + $inputValue);
}
