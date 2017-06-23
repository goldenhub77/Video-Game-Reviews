let sendSearch = () => {

  let $searchQuery = $(".main-search-field").val();
  let $videoGameId = $("#video_game_id").val();
  let $reviewsPresent = $("#review_present").val();
  let $url = $("#url").val();

  $.ajax({
    type: "GET",
    dataType: "json",
    url: `/api/v1/search`,
    data: {'search': $searchQuery, 'video_game_id': $videoGameId, 'review_present': $reviewsPresent, 'url': $url },
    success: (data) => {
      if (data.jsObjIds.length === 0 && data.notice != null) {
        $(".notice").text(data.notice);
      }else {
        $(".notice").text("")
      }
      $objectBlocks = $(`.${data.objType}-block`);
      for (i=0; i < $objectBlocks.length; i++) {
        if (data.jsObjIds.includes($objectBlocks[i].id)) {
          $(`#${$objectBlocks[i].id}`).show();
        }else {
          $(`#${$objectBlocks[i].id}`).hide();
        }
      }
    },
    error: (data) => {
      console.log("Server Request failed");
    }
  })
}
