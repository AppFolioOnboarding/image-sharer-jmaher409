class ImagesView
  def initialize; end

  def images
    Image.all.sort_by(&:created_at).reverse!.map(&:url)
  end
end
