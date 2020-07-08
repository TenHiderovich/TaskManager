# frozen_string_literal: true

class SendTaskUpdateNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_options lock: :until_and_while_executing, on_conflict: { client: :log, server: :reject }
  sidekiq_throttle_as :mailer

  def perform(task_id)
    task = Task.find(task_id)

    UserMailer.with(task: task).task_updated.deliver_now
  end
end
