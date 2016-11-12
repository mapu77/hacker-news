require 'test_helper'

class PuntuationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @puntuation = puntuations(:one)
  end

  test "should get index" do
    get puntuations_url
    assert_response :success
  end

  test "should get new" do
    get new_puntuation_url
    assert_response :success
  end

  test "should create puntuation" do
    assert_difference('Puntuation.count') do
      post puntuations_url, params: { puntuation: { contribution_id: @puntuation.contribution_id, user_id: @puntuation.user_id } }
    end

    assert_redirected_to puntuation_url(Puntuation.last)
  end

  test "should show puntuation" do
    get puntuation_url(@puntuation)
    assert_response :success
  end

  test "should get edit" do
    get edit_puntuation_url(@puntuation)
    assert_response :success
  end

  test "should update puntuation" do
    patch puntuation_url(@puntuation), params: { puntuation: { contribution_id: @puntuation.contribution_id, user_id: @puntuation.user_id } }
    assert_redirected_to puntuation_url(@puntuation)
  end

  test "should destroy puntuation" do
    assert_difference('Puntuation.count', -1) do
      delete puntuation_url(@puntuation)
    end

    assert_redirected_to puntuations_url
  end
end
