# frozen_string_literal: true

class SendEmailCheckedNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_options lock: :until_and_while_executing, on_conflict: { client: :log, server: :reject }
  sidekiq_throttle_as :mailer

  def perform(user_id, token)
    user = User.find_by(id: user_id)
    user.reset_token = token
    return if user.blank?

    UserMailer.with(user: user).email_checked.deliver_now
  end
end
