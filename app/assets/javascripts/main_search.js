let sendSearch = () => {

  let $searchQuery = $(".main-search-field").val();
  let $videoGameId = $("#video_game_id").val();
  let $reviewsPresent = $("#review_present").val();
  let $userId = $("#user_id").val();
  let $pageType = $("#page_type").val();
  let $url = $("#url").val();
  let AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

  $.ajax({
    type: "GET",
    dataType: "json",
    url: `/api/v1/search`,
    data: {'searchQuery': $searchQuery, 'videoGameId': $videoGameId, 'reviewsPresent': $reviewsPresent, 'url': $url, 'userId': $userId, 'auth': AUTH_TOKEN },
    success: (data) => {
      if (data.objects.length === 0 && data.notice != null) {
        $(".notice").text(data.notice);
      }else {
        $(".notice").text("")
      }
      $(".object-list").html("");
      for (i=0; i < data.objects.length; i++) {
        $(".object-list").append(data.html[i]);
      }
    },
    error: (data) => {
      console.log("Server Request failed");
    }
  })
}
