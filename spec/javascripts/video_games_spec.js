
describe("sendSearch", function() {
  var searchForm, ajaxData, searchData;

  beforeEach(function() {
    jasmine.Ajax.install();
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
  });

  // searchForm = $([
  //   '<form action="video_games" id="video_game_search_form" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="✓">',
  //     '<input type="text" name="search" id="video_game_search" placeholder="Search Games" size="40">',
  //     '<input type="reset" name="commit" value="Reset" id="video_game_reset_button" data-disable-with="Reset">',
  //     '<input type="submit" value="Search" id="video_game_search_button" data-disable-with="Search">',
  //   '</form>'
  // ].join('\n'));

  searchData = $("#video_game_search");
  searchData.val("overwatch");

  // ajaxData = {
  //   search: 'overwatch'
  // }

  it("sends a ajax get request to api/v1/window.location.pathname", function() {
    sendSearch();
    var request = jasmine.Ajax.requests.mostRecent();
    expect(request.method).toBe("GET");
    debugger
  });



});
