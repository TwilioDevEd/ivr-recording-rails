require 'test_helper'

class RecordingsControllerTest < ActionController::TestCase
  def setup
    @agent = agents(:one)
  end

  test "#show" do
    get :show, agent: '5551111111'
    assert_response :success
    assert_not_nil assigns(:recordings)
  end

  test "#create" do
    post :create, agent_id: 1,
      RecordingUrl: 'http://example.com/recording',
      TranscriptionText: 'Recorded',
      Caller: '+1555555555'

    assert_response :success
    assert_not_nil Recording.find_by_url("http://example.com/recording.mp3")
  end
end
