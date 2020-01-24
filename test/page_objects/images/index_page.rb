require_relative './image_card.rb'

module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      element :clear_tag_filter_link, locator: '#clear_tag_filter_link'

      collection :images, locator: 'table', item_locator: '.image-card', contains: ImageCard do
        def view!
          node.click_link('Show image')
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('New Image')
        window.change_to(NewPage)
      end

      def showing_image?(url: nil, tags: nil)
        images.find do |image|
          image.url == url && (tags.nil? || image.tags == tags)
        end
      end

      def clear_tag_filter!
        clear_tag_filter_link.node.click
        window.change_to(IndexPage)
      end
    end
  end
end
