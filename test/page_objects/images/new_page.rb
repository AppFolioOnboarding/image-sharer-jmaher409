module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images

      form_for :image do
        element :url
        element :tag_list
        element :submit_button, locator: '#image_submit'
      end

      def create_image!(url: nil, tags: nil)
        image.url.set url unless url.nil?
        image.tag_list.set tags unless tags.nil?
        image.submit_button.node.click
        window.change_to(ShowPage, NewPage)
      end
    end
  end
end
