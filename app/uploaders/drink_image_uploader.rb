class DrinkImageUploader < CarrierWave::Uploader::Base
  storage :fog # 本番環境では :fog for AWS S3, 開発環境では :file

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
