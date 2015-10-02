require 'test_helper'

class TwilioControllerTest < ActionController::TestCase
  # called before every single test
  def setup
    @agent = agents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should serve up TwiMl at ivr/welcome" do
    post :ivr_welcome, From: "15556505813"
    assert response.body.include? "Gather"
    assert_response :success
  end

  test "should Say something when 1 is chosen" do
    get :menu_selection, From: "15556505813", Digits: '1'
    assert response.body.include? "Say"
    assert_response :success
  end

  test "should Gather something when 2 is chosen" do
    get :menu_selection, From: "15556505813", Digits: '2'
    assert response.body.include? "Gather"
    assert_response :success
  end

  test "should Redirect to main menu when anything else is chosen" do
    get :menu_selection, From: "15556505813", Digits: '*'
    assert response.body.include? "Redirect"
    assert_response :success
  end

  test "/planets should Dial an outside extension" do
    get :planet_selection, From: "15556505813", Digits: '2'
    assert response.body.include? "Dial"
    assert response.body.include? "Number"
    assert_response :success
  end

  test "agent_voicemail should Say something then Record the caller" do
    post :agent_voicemail, From: "15556505813", DialCallStatus: "completed"
    assert response.body.include? "Say"
    assert response.body.include? "Record"
    assert_response :success
  end
end
