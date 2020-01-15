require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'shows error on invalid url' do
    get new_image_path
    assert_equal 200, status

    post images_path, params: { image: { url: 'foo' } }

    assert_select '#url_error_message', 1
    assert_select '#url_error_0', count: 1, text: 'Url invalid'
  end

  test 'shows index of images' do

  end
end
