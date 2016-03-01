#News feed url to be subscribed by sending subscription request to pubsubhubbub
RSS_URL = 'http://feeds.feedburner.com/NdtvNews-TopStories'

#Callback path that pubusubhubbub will hit. Once get request with challange code and then post requests with xml feeds
CALLBACK_PATH = '/pub_subs/callback'

#Timeout used for pg listner
NOTIFY_TIMEOUT = Integer(ENV['NOTIFY_TIMEOUT'] || 25)