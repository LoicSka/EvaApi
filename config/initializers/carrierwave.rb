
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    if Rails.env.production?
        config.storage = :fog
        config.fog_provider = 'fog/aws'
        config.fog_directory  =	ENV['AWS_S3_BUCKET']

        config.fog_credentials = {
            provider:               'AWS',			
            aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
            aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
            region: 'ap-northeast-1',
        }
    else
        config.storage :file
        config.asset_host = 'http://localhost:3000'
        config.enable_processing = false if Rails.env.test?    
    end
end