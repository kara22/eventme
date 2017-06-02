$(document).ready(function(){
  var events = { ids: [] };
  $(".card").on("click",function(){
    var id = $(this).attr('id');
    if (_.contains(events.ids, id)) {
      events.ids = _.without(events.ids, id);
    } else {
      events.ids.push(id);
    }
    $(this).find(".white-wrapper").toggleClass("hidden");
    var data_events = JSON.stringify(events);
    if (data_events.length > 10) {
      $(".btn-red-rounded").removeClass("hidden");
    } else {
      $(".btn-red-rounded").addClass("hidden");
    }
    $("#search-events").val(data_events);
  });
});
