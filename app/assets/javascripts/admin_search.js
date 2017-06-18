// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
let adminSearch = (resource) => {
  let $userSearch = $(".admin-user-search-field").val();
  let $videoGameSearch = $(".admin-game-search-field").val();
  let $reviewSearch = $(".admin-review-search-field").val();
  let AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

  $.ajax({
    type: "GET",
    dataType: "json",
    url: `/admins`,
    data: {'user_search': $userSearch, 'video_game_search': $videoGameSearch, 'review_search': $reviewSearch, 'auth': AUTH_TOKEN },
    success: (data) => {
      if (resource == 'video-games') {
        if (data.videoGames.objects.length === 0 && data.videoGames.notice != null) {
          $("#video-game-notice").html(data.videoGames.notice);
        }else {
          $("#video-game-notice").text("");
            $("#admins-video-games").html("");
            for (i=0; i < data.videoGames.objects.length; i++) {
              $("#admins-video-games").append(data.videoGames.objects[i].html);
          }
        }
      }
      if (resource == 'reviews') {
        if (data.reviews.objects.length === 0 && data.reviews.notice != null) {
          $("#review-notice").html(data.reviews.notice);
        }else {
            $("#review-notice").text("");
            $("#admins-reviews").html("");
            for (i=0; i < data.reviews.objects.length; i++) {
              $("#admins-reviews").append(data.reviews.objects[i].html)
          }
        }
      }
      if (resource == 'users') {
        if (data.users.objects.length === 0 && data.users.notice != null) {
          $("#user-notice").html(data.users.notice);
        }else {
            $("#admins-users").html("");
            for (i=0; i < data.users.objects.length; i++) {
              $("#admins-users").append(data.users.objects[i].html);
          }
        }
      }
    },
    error: (data) => {
      console.log("Server Request failed");
    }
  })
}
