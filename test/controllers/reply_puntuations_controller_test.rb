require 'test_helper'

class ReplyPuntuationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reply_puntuation = reply_puntuations(:one)
  end

  test "should get index" do
    get reply_puntuations_url
    assert_response :success
  end

  test "should get new" do
    get new_reply_puntuation_url
    assert_response :success
  end

  test "should create reply_puntuation" do
    assert_difference('ReplyPuntuation.count') do
      post reply_puntuations_url, params: { reply_puntuation: { reply_id: @reply_puntuation.reply_id, user_id: @reply_puntuation.user_id } }
    end

    assert_redirected_to reply_puntuation_url(ReplyPuntuation.last)
  end

  test "should show reply_puntuation" do
    get reply_puntuation_url(@reply_puntuation)
    assert_response :success
  end

  test "should get edit" do
    get edit_reply_puntuation_url(@reply_puntuation)
    assert_response :success
  end

  test "should update reply_puntuation" do
    patch reply_puntuation_url(@reply_puntuation), params: { reply_puntuation: { reply_id: @reply_puntuation.reply_id, user_id: @reply_puntuation.user_id } }
    assert_redirected_to reply_puntuation_url(@reply_puntuation)
  end

  test "should destroy reply_puntuation" do
    assert_difference('ReplyPuntuation.count', -1) do
      delete reply_puntuation_url(@reply_puntuation)
    end

    assert_redirected_to reply_puntuations_url
  end
end
