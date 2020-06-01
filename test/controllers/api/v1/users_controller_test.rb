require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase

  test "should get show" do
    user = create :user
    get :show, params: { id: user.id, format: :json }
    assert_response :success
  end

  test "should get index" do
    get :index, params: { format: :json }
    assert_response :success
  end

 end
app/controllers/api/v1/users_controller.rb:

class Api::V1::UsersController < Api::V1::ApplicationController
  def show
    user = User.find(params[:id])

    respond_with(user, serializer: UserSerializer)
  end

  def index
    users = User.ransack(ransack_params).result.page(page).per(per_page)

    respond_with(users, each_serializer: UserSerializer, meta: build_meta(users), root: 'items')
  end
end