// let sendSearch = () => {
//
//   let $inputValue = $(".main-search-field").val();
//   $.ajax({
//     type: "GET",
//     dataType: "json",
//     url: `/api/v1/${window.location.pathname}`,
//     data: {'search': $inputValue},
//     success: (data) => {
//       debugger
//       if (data.objects.length === 0) {
//         $(".notice").text(data.notice);
//       }else {
//         $(".notice").text("")
//       }
//       $(".object-list").html("");
//       for (i=0; i < data.objects.length; i++) {
//         $(".object-list").append(`<li><a href="${location.pathname}/${data.objects[i]['id']}">${data.objects[i]['title']}</a></li>`);
//       }
//     },
//     error: (data) => {
//       debugger
//       console.log("Server Request failed");
//     }
//   })
// }
