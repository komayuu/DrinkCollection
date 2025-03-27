class DrinkImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/drink/drink_image"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_allowlist
    %w(jpg jpeg png)
  end
end
