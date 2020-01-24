module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      element :delete_link, locator: '#delete_link'

      def image_url
        node.find('img')[:src]
      end

      def tags
        node.all('.image-tag').map(&:text)
      end

      def delete
        delete_link.node.click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        delete(&:accept)
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.find('#back_to_index').click
        window.change_to(IndexPage)
      end
    end
  end
end
