require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should save a valid image url' do
    assert Image.new(url: 'https://www.image.com/').valid?
  end

  test 'should not save an invalid image url' do
    image = Image.new(url: 'foo')
    assert_not image.valid?
    assert_equal ['is not a valid URL'], image.errors.messages[:url]
  end

  test 'should not save on a blank image url' do
    image = Image.new(url: '')
    assert_not image.valid?
    assert_equal ['is not a valid URL'], image.errors.messages[:url]
  end
end
