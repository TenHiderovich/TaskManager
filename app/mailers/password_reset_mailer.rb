class PasswordResetMailer < ApplicationMailer
  def email_checked
    email = params[:email]

    mail(from: 'noreply@taskmanager.com', to: email, subject: 'password reseted')
  end
end
