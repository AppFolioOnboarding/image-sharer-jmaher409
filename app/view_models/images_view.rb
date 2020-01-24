class ImagesView
  def initialize(selected_tag)
    @selected_tag = selected_tag
  end

  def image_tags(image)
    image.tag_list
  end

  def images
    images = @selected_tag.nil? ? Image.all : Image.tagged_with(@selected_tag)
    images.sort_by(&:created_at).reverse
  end
end
