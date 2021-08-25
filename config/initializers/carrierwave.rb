require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? 
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id_s3],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key_s3],
      region: 'ap-northeast-1' 
    }
    config.fog_directory  = 'food-takeout-map' 
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/food-takeout-map'
  else
    config.storage :file 
    config.enable_processing = false if Rails.env.test? 
  end  
end