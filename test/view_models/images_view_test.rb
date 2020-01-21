require 'test_helper'

FIRST_TAG = 'first_tag'.freeze
SECOND_TAG = 'second_tag'.freeze
TEST_URLS = [
  'https://www.google.com/sample1.jpg',
  'https://www.google.com/sample2.jpg',
  'https://www.google.com/sample3.jpg'
].freeze

class ImagesViewTest < ActiveSupport::TestCase
  test '.images sorts by created_at' do
    TEST_URLS.each do |test_url|
      Image.create!(url: test_url)
    end

    images_view = ImagesView.new(nil)

    assert_equal TEST_URLS.reverse, images_view.images
  end

  test '.images only returns images with tag if tag is not nil' do
    setup_test_data_with_tags

    images_view = ImagesView.new(SECOND_TAG)

    expected_urls = [TEST_URLS[2], TEST_URLS[1]]

    assert_equal expected_urls, images_view.images
  end

  test '.tags returns all used tags' do
    setup_test_data_with_tags

    images_view = ImagesView.new(nil)

    assert_equal [FIRST_TAG, SECOND_TAG], images_view.tags.map(&:name)
  end

  private

  def setup_test_data_with_tags
    TEST_URLS.each_with_index do |test_url, index|
      image = Image.create!(url: test_url)
      tag = index.zero? ? FIRST_TAG : SECOND_TAG
      image.tag_list.add(tag)
      image.save
    end
  end
end
