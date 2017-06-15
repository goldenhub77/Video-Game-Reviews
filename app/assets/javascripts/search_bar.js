let sendSearch = () => {

  let $searchQuery = $(".main-search-field").val();
  let $videoGameId = $("#video_game_id").val();
  let $reviewsPresent = $("#review_present").val();
  let $userId = $("#user_id").val();
  let $pageType = $("#page_type").val();
  let $url = $("#url").val();

  $.ajax({
    type: "GET",
    dataType: "json",
    url: `/api/v1/${$pageType}`,
    data: {'searchQuery': $searchQuery, 'videoGameId': $videoGameId, 'reviewsPresent': $reviewsPresent, 'url': $url, 'userId': $userId },
    success: (data) => {

      if (data.objects.length === 0 && data.notice != null) {
        $(".notice").text(data.notice);
      }else {
        $(".notice").text("")
      }
      $(".object-list").html("");
      for (i=0; i < data.objects.length; i++) {
        $(".object-list").append(`<li><a href="${location.pathname}/${data.objects[i]['id']}">${data.objects[i]['title']}</a></li>`);
      }
    },
    error: (data) => {
      debugger
      console.log("Server Request failed");
    }
  })
}
