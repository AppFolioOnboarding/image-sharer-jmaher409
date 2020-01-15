require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test '.new shows a view for creating an image' do
    get new_image_path

    assert_response :success
    assert_select 'input[type=url]', 1
    assert_select 'input[type=submit]', 1
  end

  test '.create shows error on invalid url' do
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { url: 'foo' } }
    end

    assert_response :unprocessable_entity

    assert_select 'span', 'is not a valid URL'
  end

  test '.create creates an image record' do
    test_url = 'https://www.google.com'

    assert_difference 'Image.count' do
      post images_path, params: { image: { url: test_url } }
    end

    assert_redirected_to image_path(Image.last.id)
  end

  test '.show shows an image' do
    test_url = 'http://www.google.com'
    Image.create!(url: test_url)

    get image_path(Image.last.id)

    assert_response :ok
    assert_select 'img', 1 do
      assert_select '[src=?]', test_url
    end
  end

  test '.show redirects to new_image_path when non-existent id is given' do
    get images_path + '/300'

    follow_redirect!

    assert_response :success
  end
end
