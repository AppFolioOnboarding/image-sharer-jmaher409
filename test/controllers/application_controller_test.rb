require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'renders content for root path' do
    get '/'
    assert_equal 200, status
  end
end
