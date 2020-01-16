require 'test_helper'

class ImagesViewTest < ActiveSupport::TestCase
  test '.sort_images sorts by created_at' do
    test_urls = [
      'https://www.google.com/sample1.jpg',
      'https://www.google.com/sample2.jpg',
      'https://www.google.com/sample3.jpg'
    ]

    test_urls.each do |test_url|
      Image.create!(url: test_url)
    end

    images_view = ImagesView.new(Image.all)

    assert_equal test_urls.reverse!, images_view.sort_images
  end
end
