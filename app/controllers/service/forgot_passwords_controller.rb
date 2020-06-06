# frozen_string_literal: true

class Service::ForgotPasswordsController < Service::ApplicationController
  def new
    @email = EmailForm.new
  end

  def create
    @email = EmailForm.new(password_params)

    if @email.valid?
      PasswordResetMailer.with({ email: @email }).email_checked.deliver_now
      # redirect_to email_confirmed
    else
      render :new
    end
  end

  private

  def password_params
    params.require(:email_form).permit(:email)
  end
end