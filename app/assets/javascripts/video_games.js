// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function setRating() {
  $inputValue = $("#video_game_rating").val();
  $label = $("#video_game_rating").siblings("label");
  $label.text("(0 worst - 5 best) Rating: " + $inputValue);
}

function sendSearch() {

  $inputValue = $("#video_games_search").val();
  $.ajax({
    type: "GET",
    url: "/api/v1/search",
    data: {'search': $inputValue},
    success: function(data) {
      $("#video_game_list").html("");
      $dataArr = JSON.parse(data);
      for (i=0; i < $dataArr.length; i++) {
        $("#video_game_list").append(`<li><a href="/video_games/${$dataArr[i]['id']}">${$dataArr[i]['title']}</a></li>`);
      }
      $("#video_game_search_form input").attr("disabled", false);
    },
    error: function(data) {
      console.log("Server Request failed");
    },
    done: function() {

    }
  })
}

$(document).ready(function() {
  setRating();
  $("#video_game_rating").on("mousemove keyup", setRating);
  $("#video_game_search_form").on("submit", function(event) {
    event.preventDefault();
    sendSearch();
  });
  $("#video_game_reset_button").on("click", function(event) {
    event.preventDefault();
    $result = $("#video_game_search");
    $result.val("")
    sendSearch();
  })
})
