# frozen_string_literal: true

class SendTaskDestroyNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_options lock: :until_and_while_executing, on_conflict: { client: :log, server: :reject }
  sidekiq_throttle_as :mailer

  def perform(task_id, email)
    UserMailer.with(task_id: task_id, email: email).task_destroyed.deliver_now
  end
end
