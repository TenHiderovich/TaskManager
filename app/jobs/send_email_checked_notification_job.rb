class SendEmailCheckedNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(user)
    user = User.find_by(id: user_id)
    return if user.blank?

    UserMailer.with(user: user).email_checked.deliver_now
  end
end