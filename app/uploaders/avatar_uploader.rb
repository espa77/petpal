class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  process :custom_resize => [800,800]
  def custom_resize(w, h)
    current_path = self.file.file
    rmagick_image = ::Magick::Image.read(current_path).first
    if (rmagick_image.columns <= w || rmagick_image.rows <= h)
      white_fill = Magick::GradientFill.new(0, 0, 0, 0, "#FFF", "#FFF")
      dst = Magick::Image.new(w, h, white_fill)
      result = dst.composite(rmagick_image, Magick::CenterGravity, Magick::OverCompositeOp)
      result.write(current_path)
    else
      self.resize_and_pad(w, h)
    end
  end
  version :large do
    process :custom_resize => [800, 800]
  end
  version :medium do
    process :custom_resize => [500, 500]
  end
  version :small do
    process :custom_resize => [300, 300]
  end
  version :thumb do
    process :custom_resize => [100, 100]
  end
  version :square do
    process :resize_to_limit => [800, 800]
  end
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
