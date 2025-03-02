class DrinkImageUploader < CarrierWave::Uploader::Base
  storage :file  # 本番環境では :fog for AWS S3

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
