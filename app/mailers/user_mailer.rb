# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def task_created
    user = params[:user]
    @task = params[:task]

    mail(to: user.email, subject: 'New Task Created')
  end

  def task_updated
    user = params[:user]
    @task = params[:task]

    mail(to: user.email, subject: "Task #{@task.id} Updated")
  end

  def task_destroyed
    email = params[:email]
    @task_id = params[:task_id]

    mail(to: email, subject: "Task #{@task_id} Destroyed")
  end

  def email_checked
    @user = params[:user]

    mail(to: @user.email, subject: 'password reseted')
  end
end
