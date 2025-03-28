require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_provider = "fog/aws"
    config.fog_directory  = ENV["S3_BUCKET_NAME"]
    config.fog_public = true
    config.asset_host = "https://#{ENV['S3_BUCKET_NAME']}.s3.#{ENV['S3_REGION']}.amazonaws.com"
    config.fog_credentials = {
      provider: "aws",
      aws_access_key_id: ENV["S3_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
      region: ENV["S3_REGION"],
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
