require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should save a valid image url' do
    image = Image.new(url: 'https://www.image.com/')
    assert image.save
  end

  test 'should not save an invalid image url' do
    image = Image.new(url: 'foo')
    assert_not image.save
  end
end
