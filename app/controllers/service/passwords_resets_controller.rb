# frozen_string_literal: true

class Service::PasswordsResetsController < Service::ApplicationController
  before_action :get_user,         only: %i[edit update]
  before_action :check_token, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def show; end

  def new
    @email = EmailForm.new
  end

  def edit; end

  def create
    @email = EmailForm.new(email_params)

    if @email.valid?
      @user = @email.user
      @user.create_reset_digest!
      SendEmailCheckedNotificationJob.perform_async(@user.id, @user.reset_token)
    end

    render :show
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
      redirect_to :new_service_passwords_reset
    end
  end

  def check_expiration
    redirect_to :new_service_passwords_reset if @user.password_reset_expired?
  end
end
