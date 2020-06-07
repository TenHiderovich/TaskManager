# frozen_string_literal: true

require 'test_helper'

class Service::PasswordResetsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    user = create :user
    email_attrs = {
      email: user.email
    }

    assert_emails 1 do
      post :create, params: { email_form: email_attrs }
    end

    assert_response :success

    assert_not_equal user.reset_digest, user.reload.reset_digest
  end

  test 'should post update' do
    user = create :user

    password = generate(:password)
    user_attrs = attributes_for(:user)
                 .merge({ password_digest: password })
                 .stringify_keys

    patch :update, params: { id: user.id, email: user.email, user: user_attrs }
    assert_response :redirect
  end
end
