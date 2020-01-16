class ImagesView
  def initialize(images)
    @images = images
  end

  def sort_images
    @images.sort_by(&:created_at).reverse!.map(&:url)
  end
end
