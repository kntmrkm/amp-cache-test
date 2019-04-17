# AMP キャッシュ更新

## 

```
curl -I http:/lvh.me:3002/.well-known/amphtml/apikey.pub
curl -I https://amp-cache-test.herokuapp.com/.well-known/amphtml/apikey.pub

client = Google::AMP::Cache::Client.new ENV['GOOGLE_AMP_API_KEY'], File.read("#{Rails.root}/config/amp-cache-private-key.pem")
client.update_cache('https://amp-cache-test.herokuapp.com/home.amp')
client.batch_get('https://amp-cache-test.herokuapp.com/home.amp')
```

```
irb(main):006:0> client.batch_get('https://amp-cache-test.herokuapp.com/home.amp')
=> {"urlErrors"=>[{"errorCode"=>"NO_AMP_URL", "errorMessage"=>"No AMP URL for the request URL.", "originalUrl"=>"https://amp-cache-test.herokuapp.com/home.amp"}]}
irb(main):007:0> client.batch_get('https://amp-cache-test.herokuapp.com/home.html')
=> {"ampUrls"=>[{"originalUrl"=>"https://amp-cache-test.herokuapp.com/home.html", "ampUrl"=>"https://amp-cache-test.herokuapp.com/home.amp", "cdnAmpUrl"=>"https://amp--cache--test-herokuapp-com.cdn.ampproject.org/c/s/amp-cache-test.herokuapp.com/home.amp"}]}
```