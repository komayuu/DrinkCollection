class PostImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def store_dir
    "uploads/post/post_image"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def default_url
    "post_placeholder"
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
