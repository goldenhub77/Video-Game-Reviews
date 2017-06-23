// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
let adminSearch = (resource) => {
  let $userSearch = $(".admin-user-search-field").val();
  let $videoGameSearch = $(".admin-game-search-field").val();
  let $reviewSearch = $(".admin-review-search-field").val();

  $.ajax({
    type: "GET",
    dataType: "json",
    url: `/admins`,
    data: {'user_search': $userSearch, 'video_game_search': $videoGameSearch, 'review_search': $reviewSearch },
    success: (data) => {
      if (resource == 'video-games') {
        if (data.jsVideoGames.ids.length === 0 && data.notice != null) {
          $("#video-game-notice").html(data.notice);
        }else {
          $("#video-game-notice").html("");
          $objectBlocks = $(`#admins-${data.jsVideoGames.type} > tbody > tr`);
          for (i=0; i < $objectBlocks.length; i++) {
            if (data.jsVideoGames.ids.includes($objectBlocks[i].id)) {
              $(`#${$objectBlocks[i].id}`).show();
            }else {
              $(`#${$objectBlocks[i].id}`).hide();
            }
          }
        }
      }
      if (resource == 'reviews') {
        if (data.jsReviews.ids.length === 0 && data.notice != null) {
          $("#review-notice").html(data.notice);
        }else {
          $("#review-notice").html("");
          $objectBlocks = $(`#admins-${data.jsReviews.type} > tbody > tr`);
          for (i=0; i < $objectBlocks.length; i++) {
            if (data.jsReviews.ids.includes($objectBlocks[i].id)) {
              $(`#${$objectBlocks[i].id}`).show();
            }else {
              $(`#${$objectBlocks[i].id}`).hide();
            }
          }
        }
      }
      if (resource == 'users') {
        if (data.jsUsers.ids.length === 0 && data.notice != null) {
          $("#user-notice").html(data.notice);
        }else {
          $("#user-notice").html("");
          $objectBlocks = $(`#admins-${data.jsUsers.type} > tbody > tr`);
          for (i=0; i < $objectBlocks.length; i++) {
            if (data.jsUsers.ids.includes($objectBlocks[i].id)) {
              $(`#${$objectBlocks[i].id}`).show();
            }else {
              $(`#${$objectBlocks[i].id}`).hide();
            }
          }
        }
      }
    },
    error: (data) => {
      console.log("Server Request failed");
    }
  })
}
