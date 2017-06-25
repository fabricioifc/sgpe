class PictureUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave
  # include CarrierWave::MiniMagick

  process :convert => 'png'
  process :tags => ['post_picture']

  # def filename
  #    "original.#{model.logo.file.extension}" if original_filename
  # end

  version :medium do
    process :resize_to_fill => [300, 300]
  end

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :thumb do
    resize_to_fit(50, 50)
  end

  version :small do
    process :resize_to_fit => [190, 190]
    process :convert => 'gif'
  end
  version :icon do
    process :resize_to_fill => [50, 50]
    process :convert => 'gif'
  end

  # def public_id
  #   return model.short_name
  # end

end
