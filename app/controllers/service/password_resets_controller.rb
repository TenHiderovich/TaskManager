# frozen_string_literal: true

class Service::PasswordResetsController < Service::ApplicationController
  before_action :get_user,         only: %i[edit update]
  before_action :check_token,       only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new
    @email = EmailForm.new
  end

  def create
    @email = EmailForm.new(email_params)

    if @email.user_valid?
      @user = @email.user
      @user.create_reset_digest!
      UserMailer.with({ user: @user }).email_checked.deliver_now
    end

    render :template => "service/password_resets/check"
  end

  def update
    PasswordResetForm.new(password_params)
    if @user.update(password_params)
      @user.destroy_reset_digest!
      redirect_to new_session_path
    else
      render :edit
    end
  end

  def edit; end

  private

  def email_params
    params.require(:email_form).permit(:email)
  end

  def password_params
    user_type = @user.type.downcase
    params.require(user_type).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def check_token
    reset_token = params[:id]
    unless @user&.authenticated_reset_token?(reset_token)
      redirect_to :new_service_password_reset
    end
  end

  def check_expiration
    redirect_to :new_service_password_reset if @user.password_reset_expired?
  end
end
