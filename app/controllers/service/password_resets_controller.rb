# frozen_string_literal: true

class Service::PasswordResetsController < Service::ApplicationController
  before_action :get_user,         only: %i[edit update]
  before_action :valid_user,       only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new
    @email = EmailForm.new
  end

  def create
    @email = EmailForm.new(email_params)

    if @email.valid?
      @user = @email.user
      @user.create_reset_digest

      UserMailer.with({ user: @user }).email_checked.deliver_now

      render :check_email
    else
      render :new
    end
  end

  def update
    PasswordResetForm.new(password_params)
    if @user.update(password_params)
      @user.destroy_reset_digest
      redirect_to new_session_path
    else
      render :edit
    end
  end

  def edit; end

  def check_email; end

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

  def valid_user
    redirect_to :new_service_password_reset unless @user&.authenticated?(params[:id])
  end

  def check_expiration
    redirect_to :new_service_password_reset if @user.password_reset_expired?
  end
end
