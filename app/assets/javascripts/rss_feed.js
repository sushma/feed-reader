setTimeout((function() {
  var source;
  source = new EventSource('/events');
  source.addEventListener("refresh", function(e) {
    getFeed($.parseJSON(e.data).feed_id);
  });
}), 1);
function getFeed(feed_id){
  $.ajax({
    url: "rss_feeds/" + feed_id,
    type: 'GET',
    dataType: 'script'
  });
}