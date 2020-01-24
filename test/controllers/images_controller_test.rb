require 'test_helper'

SAVE_SUCCESSFUL_MESSAGE = 'You have successfully added an image.'.freeze

# rubocop:disable Metrics/ClassLength
class ImagesControllerTest < ActionDispatch::IntegrationTest
  test '.new shows a view for creating an image' do
    get new_image_path

    assert_response :success
    assert_select 'input[type=url]', 1
    assert_select 'input[type=submit]', 1
    assert_select '#image_tag_list', 1
  end

  test '.create shows error on invalid url' do
    assert_no_difference 'Image.count' do
      post images_path, params: { image: { url: 'foo' } }
    end

    assert_response :ok

    assert_select 'span', 'must be a valid URL'
  end

  test '.create creates an image record with no tags if no tags given' do
    test_url = 'https://www.google.com'

    assert_difference 'Image.count' do
      post images_path, params: { image: { url: test_url } }
    end

    assert_redirected_to image_path(Image.last.id)

    assert_equal SAVE_SUCCESSFUL_MESSAGE, flash[:success]

    image = Image.find_by(id: Image.last.id)

    assert_equal [], image.tag_list
  end

  test '.create creates an image record with tags if tags given' do
    test_url = 'https://www.google.com'

    assert_difference 'Image.count' do
      post images_path, params: { image: { url: test_url, tag_list: 'foo, bar' } }
    end

    assert_redirected_to image_path(Image.last.id)

    assert_equal SAVE_SUCCESSFUL_MESSAGE, flash[:success]

    image = Image.find_by(id: Image.last.id)

    assert_equal %w[foo bar], image.tag_list
  end

  test '.show shows an image and has delete link' do
    test_url = 'http://www.google.com'
    Image.create!(url: test_url)

    get image_path(Image.last.id)

    assert_response :ok
    assert_select 'a', text: 'Delete Image'
    assert_select 'img', 1 do
      assert_select '[src=?]', test_url
    end
  end

  test '.show redirects to new_image_path when non-existent id is given' do
    get images_path + '/300'

    follow_redirect!

    assert_response :success
  end

  test '.show on an image without tags does not show tags' do
    test_url = 'http://www.google.com'
    Image.create!(url: test_url)

    get image_path(Image.last.id)

    assert_response :ok

    assert_select '#image_tags' do
      assert_select 'h4', text: 'Tags'
      assert_select 'li', 0
    end
  end

  test '.show on an image with tags shows tags' do
    test_url = 'http://www.google.com'
    Image.create!(url: test_url)
    image = Image.find_by(id: Image.last.id)
    image.tag_list.add('foo', 'bar')
    image.save

    get image_path(Image.last.id)

    assert_response :ok

    assert_select '#image_tags' do
      assert_select 'h4', text: 'Tags'
      assert_select '#line_item_0', text: 'foo'
      assert_select '#line_item_1', text: 'bar'
    end
  end

  test '.index does not show images section if there are none' do
    view_model_mock = mock
    ImagesView.expects(:new).returns(view_model_mock)
    view_model_mock.expects(:images).returns([])
    view_model_mock.expects(:tags).returns([])

    get images_url

    assert_response :ok

    assert_select 'img', 0
    ImagesView.unstub(:new)
    view_model_mock.unstub(:images)
    view_model_mock.unstub(:tags)
  end

  test '.index shows images sorted from newest to oldest' do
    test_images = [
      Image.create(url: 'https://www.google.com/sample1.jpg'),
      Image.create(url: 'https://www.google.com/sample2.jpg'),
      Image.create(url: 'https://www.google.com/sample3.jpg')
    ]

    view_model_mock = mock
    ImagesView.expects(:new).returns(view_model_mock)
    view_model_mock.expects(:images).returns(test_images.reverse)
    view_model_mock.stubs(:image_tags).returns([])

    get images_url

    assert_response :ok

    assert_select 'img' do |elements|
      assert(elements.all? { |e| e.attributes['class'].value.include? 'index-image' })
      img_tag_srcs = elements.map { |e| e.attributes['src'].value }
      assert_equal test_images.reverse.map(&:url), img_tag_srcs
    end

    ImagesView.unstub(:new)
    view_model_mock.unstub(:images)
    view_model_mock.unstub(:image_tags)
  end

  test '.index passes id to images_view on entry' do
    view_model_mock = mock
    ImagesView.expects(:new).with('foo').returns(view_model_mock)
    view_model_mock.expects(:tags).returns([])
    view_model_mock.expects(:images).returns([])

    get images_path, params: { tag: 'foo' }

    assert_response :ok

    ImagesView.unstub(:new)
    view_model_mock.unstub(:images)
    view_model_mock.unstub(:tags)
  end

  test '.destroy deletes an image that exists' do
    test_url = 'http://www.google.com'

    Image.create!(url: test_url)
    id = Image.last.id
    created_image = Image.find_by(id: id)
    assert_not created_image.nil?

    delete image_path(id)
    assert_response 302

    created_image = Image.find_by(id: id)
    assert created_image.nil?
  end

  test '.destroy does nothing if image does not exist' do
    delete image_path(6)

    assert_response 302
    assert_not flash[:success]

    assert_redirected_to images_path
  end
end

# rubocop:enable Metrics/ClassLength
