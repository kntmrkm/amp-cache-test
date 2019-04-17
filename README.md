# AMP キャッシュ更新

## 設定概要

- RSA 鍵を生成する configディレクトリ下でやればよい
  - openssl genrsa 2048 > amp-cache-private-key.pem
  - openssl rsa -in amp-cache-private-key.pem -pubout > amp-cache-public-key.pem
  - amp-cache-public-key.pem を `public/.well-known/amphtml/apikey.pub` に設置する
  - Railsの設定で `config/initializers/mime_types.rb` に `Rack::Mime::MIME_TYPES[".pub"]="text/plain"` を設定する
- APIの有効化 https://console.cloud.google.com/
  - Accelerated Mobile Pages (AMP) URL API
  - 認証情報を作ってAPIキーを取得する
  - 環境変数に設定する（GOOGLE_AMP_API_KEY）

## メモ

`https://amp--cache--test-herokuapp-com.cdn.ampproject.org/c/s/amp-cache-test.herokuapp.com/home.amp`
上記にアクセスすると、Botが見にくるが、更新されるまでタイムラグが１分弱（体感）である感じ。



## 

```
curl -I https://amp-cache-test.herokuapp.com/.well-known/amphtml/apikey.pub

client = Google::AMP::Cache::Client.new ENV['GOOGLE_AMP_API_KEY'], File.read("#{Rails.root}/config/amp-cache-private-key.pem")
client.update_cache('https://amp-cache-test.herokuapp.com/home.amp')
client.batch_get('https://amp-cache-test.herokuapp.com/home.html')
```

```
irb(main):006:0> client.batch_get('https://amp-cache-test.herokuapp.com/home.amp')
=> {"urlErrors"=>[{"errorCode"=>"NO_AMP_URL", "errorMessage"=>"No AMP URL for the request URL.", "originalUrl"=>"https://amp-cache-test.herokuapp.com/home.amp"}]}
irb(main):007:0> client.batch_get('https://amp-cache-test.herokuapp.com/home.html')
=> {"ampUrls"=>[{"originalUrl"=>"https://amp-cache-test.herokuapp.com/home.html", "ampUrl"=>"https://amp-cache-test.herokuapp.com/home.amp", "cdnAmpUrl"=>"https://amp--cache--test-herokuapp-com.cdn.ampproject.org/c/s/amp-cache-test.herokuapp.com/home.amp"}]}
```