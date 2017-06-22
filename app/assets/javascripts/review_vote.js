let reviewVote = (currentAction) => {

  let AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
  $.ajax({
    type: "POST",
    dataType: "json",
    url: `${currentAction}`,
    data: { 'auth': AUTH_TOKEN },
    success: (data) => {
      $(`#up-vote-btn-${data.id}`)[0].disabled = data.upVote;
      $(`#down-vote-btn-${data.id}`)[0].disabled = data.downVote;
      $(`#js-vote-message-${data.id}`).html("");
      $(`#js-vote-message-${data.id}`).append(data.html);
    },
    error: (data) => {
      console.log("Server Request failed");
    }
  })
}
