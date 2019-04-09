namespace :amp do
  desc 'AMP cache clear'
  task cache: :environment do
    # https://amp-cache-test.herokuapp.com/.well-known/amphtml/apikey.pub
    client = Google::AMP::Cache::Client.new ENV['GOOGLE_AMP_API_KEY'], File.read("#{Rails.root}/config/amp-cache-private-key.pem")
    client.update_cache('https://amp-cache-test.herokuapp.com/home.amp')
  end
end
