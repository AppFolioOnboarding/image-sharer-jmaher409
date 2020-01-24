module PageObjects
  class Document < AePageObjects::Document
    def flash_message(_message_type)
      node.find('.flash-message').text
    end
  end
end
