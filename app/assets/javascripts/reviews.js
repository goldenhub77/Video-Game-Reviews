// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// let sendSearch = () => {
//
//   let $inputValue = $("#video_game_search").val();
//   $.ajax({
//     type: "GET",
//     dataType: "json",
//     url: `/api/v1/search${window.location.pathname}`,
//     data: {'search': $inputValue},
//     success: (data) => {
//       let $reviews = data.reviews;
//       if ($reviews.length === 0) {
//         $(".notice").text(data.notice);
//       }else {
//         $(".notice").text("")
//       }
//       $("#video-game-review-list").html("");
//       for (i=0; i < $reviews.length; i++) {
//         $("#video-game-review-list").append(`<li><a href="/video_game_reviews/${$reviews[i]['id']}">${$reviews[i]['title']}</a></li>`);
//       }
//     },
//     error: (data) => {
//       console.log("Server Request failed");
//     }
//   })
//
// }
//
// $(document).ready( () => {
//
//   $("#video_game_review_search_button").on("click", function(event) {
//     event.preventDefault();
//     sendSearch();
//   });
//   $("#video_game_reset_button").on("click", function(event) {
//     event.preventDefault();
//     $("#video_game_search").val("")
//     sendSearch();
//
//   })
// })
