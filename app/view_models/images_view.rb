class ImagesView
  def initialize(tag)
    @tag = tag
  end

  def tags
    ActsAsTaggableOn::Tag.all
  end

  def images
    images = @tag.nil? ? Image.all : Image.tagged_with(@tag)
    images.sort_by(&:created_at).reverse!.map(&:url)
  end
end
