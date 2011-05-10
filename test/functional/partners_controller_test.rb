require 'test_helper'

class PartnersControllerTest < ActionController::TestCase
  setup do
    @partner = partners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partner" do
    assert_difference('Partner.count') do
      post :create, :partner => @partner.attributes
    end

    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should show partner" do
    get :show, :id => @partner.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @partner.to_param
    assert_response :success
  end

  test "should update partner" do
    put :update, :id => @partner.to_param, :partner => @partner.attributes
    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should destroy partner" do
    assert_difference('Partner.count', -1) do
      delete :destroy, :id => @partner.to_param
    end

    assert_redirected_to partners_path
  end
end
