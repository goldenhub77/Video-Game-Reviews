// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery
//= require rails-ujs
//= require bootstrap
//= require jquery.slimscroll.min
//= require_tree .


$(document).ready( () => {
  setRating();

  $(".range-field").on("mousemove keydown keyup", () => {
    setRating();
  });

  $(".search-submit-btn").on("click", (event) => {
    event.preventDefault();
    sendSearch();
  });

  $(".search-reset-btn").on("click", (event) => {
    event.preventDefault();
    $(".main-search-field").val("")
    sendSearch();
  })

  $(".admin-game-reset-btn").on("click", (event) => {
    event.preventDefault();
    $(".admin-game-search-field").val("");
    adminSearch('video-games');
  })

  $(".admin-review-reset-btn").on("click", (event) => {
    event.preventDefault();
    $(".admin-review-search-field").val("");
    adminSearch('reviews');
  })

  $(".admin-user-reset-btn").on("click", (event) => {
    event.preventDefault();
    $(".admin-user-search-field").val("");
    adminSearch('users');
  })

  $(".admin-review-submit-btn").on("click", (event) => {
    event.preventDefault();
    adminSearch('reviews');
  })

  $(".admin-video-games-submit-btn").on("click", (event) => {
    event.preventDefault();
    adminSearch('video-games');
  })

  $(".admin-user-submit-btn").on("click", (event) => {
    event.preventDefault();
    adminSearch('users');
  })

})
