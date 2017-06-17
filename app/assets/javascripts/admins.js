// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
let adminSearch = () => {

  let $userSearch = $(".admin-user-search-field").val();
  let $videoGameSearch = $(".admin-game-search-field").val();
  let $reviewSearch = $(".admin-review-search-field").val();
  let AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

  $.ajax({
    type: "GET",
    dataType: "json",
    url: `/admins`,
    data: {'user_search': $userSearch, 'video_game_search': $videoGameSearch, 'review_search': $reviewSearch },
    success: (data) => {
      if (data.videoGames.objects.length === 0 && data.videoGames.notice != null) {
        $(".notice").text("")
        $("#video-game-notice").html(data.videoGames.notice);
      }else {
        $(".notice").text("")
        $("#video-game-notice").text("");
          $("#admins-video-games").html("");
          for (i=0; i < data.videoGames.objects.length; i++) {
            let html =  `<tr>
              <td>${data.videoGames.objects[i].gamePublished}</td>
              <td>${data.videoGames.objects[i].game.title}</td>
              <td>${data.videoGames.objects[i].user.first_name} ${data.videoGames.objects[i].user.last_name}</td>
              <td>${data.videoGames.objects[i].user.email}</td>
              <td><form class="button_to" method="get" action="/video_games/${data.videoGames.objects[i].game.id}"><input class="btn btn-secondary" type="submit" value="Show"></form></td>
              <td><form class="button_to" method="post" action="/video_games/${data.videoGames.objects[i].game.id}"><input type="hidden" name="_method" value="delete"><input data-confirm="Are you sure?" class="btn btn-danger" type="submit" value="Delete"><input type="hidden" name="authenticity_token" value="${AUTH_TOKEN}"></form></td>
            </tr>`;

            $("#admins-video-games").append(html);
        }
      }
      if (data.reviews.objects.length === 0 && data.reviews.notice != null) {
        $("#review-notice").html(data.reviews.notice);
      }else {
          $("#review-notice").text("");
          $("#admins-reviews").html("");
          for (i=0; i < data.reviews.objects.length; i++) {
            $("#admins-reviews").append(`<tr>
              <td>${data.reviews.objects[i].reviewPublished}</td>
              <td>${data.reviews.objects[i].review.title}</td>
              <td>${data.reviews.objects[i].game.title}</td>
              <td>${data.reviews.objects[i].fullName}</td>
              <td>${data.reviews.objects[i].user.email}</td>
              <td><form class="button_to" method="get" action="/admins/reviews/${data.reviews.objects[i].review.id}"><input class="btn btn-secondary" type="submit" value="Show"></form></td>
              <td><form class="button_to" method="post" action="/reviews/${data.reviews.objects[i].review.id}"><input type="hidden" name="_method" value="delete"><input data-confirm="Are you sure?" class="btn btn-danger" type="submit" value="Delete"><input type="hidden" name="authenticity_token" value="${AUTH_TOKEN}"></form></td>
            </tr>`);
        }
      }
      if (data.users.objects.length === 0 && data.users.notice != null) {
        $("#user-notice").html(data.users.notice);
      }else {
          $("#user-notice").text("");
          $("#admins-users").html("");
          for (i=0; i < data.users.objects.length; i++) {
            $("#admins-users").append(`<tr>
              <td>${data.users.objects[i].userJoined}</td>
              <td>${data.users.objects[i].fullName}</td>
              <td>${data.users.objects[i].user.email}</td>
              <td><a href="/admins/users/${data.users.objects[i].user.id}/video_games">${data.users.objects[i].videoGameCount}</a></td>
              <td><a href="/admins/users/${data.users.objects[i].user.id}/reviews">${data.users.objects[i].reviewCount}</a></td>
              <td><form class="button_to" method="get" action="/admins/users/${data.users.objects[i].user.id}"><input class="btn btn-secondary" type="submit" value="Show"></form></td>
              <td><form class="button_to" method="post" action="/users/${data.users.objects[i].user.id}"><input type="hidden" name="_method" value="delete"><input data-confirm="Are you sure?" class="btn btn-danger" type="submit" value="Delete"><input type="hidden" name="authenticity_token" value="${AUTH_TOKEN}"></form></td>
            </tr>`);
        }
      }
    },
    error: (data) => {
      debugger
      console.log("Server Request failed");
    }
  })
}
