require 'test_helper'

class CommentPuntuationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment_puntuation = comment_puntuations(:one)
  end

  test "should get index" do
    get comment_puntuations_url
    assert_response :success
  end

  test "should get new" do
    get new_comment_puntuation_url
    assert_response :success
  end

  test "should create comment_puntuation" do
    assert_difference('CommentPuntuation.count') do
      post comment_puntuations_url, params: { comment_puntuation: { comment_id: @comment_puntuation.comment_id, user_id: @comment_puntuation.user_id } }
    end

    assert_redirected_to comment_puntuation_url(CommentPuntuation.last)
  end

  test "should show comment_puntuation" do
    get comment_puntuation_url(@comment_puntuation)
    assert_response :success
  end

  test "should get edit" do
    get edit_comment_puntuation_url(@comment_puntuation)
    assert_response :success
  end

  test "should update comment_puntuation" do
    patch comment_puntuation_url(@comment_puntuation), params: { comment_puntuation: { comment_id: @comment_puntuation.comment_id, user_id: @comment_puntuation.user_id } }
    assert_redirected_to comment_puntuation_url(@comment_puntuation)
  end

  test "should destroy comment_puntuation" do
    assert_difference('CommentPuntuation.count', -1) do
      delete comment_puntuation_url(@comment_puntuation)
    end

    assert_redirected_to comment_puntuations_url
  end
end
