module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      element :image, locator: '.index-image'
      element :tag_list, locator: '.tag-list'

      def url
        node.find('.index-image')[:src]
      end

      def tags
        node.all('.image-tag').map(&:text)
      end

      def click_tag!(tag_name)
        node.find("#tag_link_#{tag_name}").click
        window.change_to(IndexPage)
      end
    end
  end
end
