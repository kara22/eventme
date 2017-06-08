$(document).ready(function(){
  var events = { ids: [] };
  $(".card").on("click",function(){
    var id = $(this).attr('id');
    if (_.contains(events.ids, id)) {
      events.ids = _.without(events.ids, id);
    } else {
      events.ids.push(id);
    }
    $(this).find(".black-wrapper").toggleClass("hidden");
    var data_events = JSON.stringify(events);
    if (data_events.length > 10) {
      $("#meet-button").removeClass("hidden");
    } else {
      $("#meet-button").addClass("hidden");
    }
    $("#search-events").val(data_events);
  });
});
