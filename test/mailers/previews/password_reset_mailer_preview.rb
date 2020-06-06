# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class PasswordResetMailerPreview < ActionMailer::Preview
  def email_checked
    user = User.first
    email = user.email
    params = { email: email }

    PasswordResetMailer.with(params).email_checked
  end
end