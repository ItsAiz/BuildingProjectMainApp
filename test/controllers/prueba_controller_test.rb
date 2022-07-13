require "test_helper"

class PruebaControllerTest < ActionDispatch::IntegrationTest
  test "should get prueba" do
    get prueba_prueba_url
    assert_response :success
  end
end
