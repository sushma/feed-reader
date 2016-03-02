setTimeout((function() {
  var source;
  source = new EventSource('/events');
  source.addEventListener("refresh", function(e) {
    getFeed($.parseJSON(e.data).rss_feed_ids);
  });
}), 1);
function getFeed(rss_feed_ids){
  $.ajax({
    url: "rss_feeds/recent?rss_feed_ids=" + rss_feed_ids,
    type: 'GET',
    dataType: 'script'
  });
}