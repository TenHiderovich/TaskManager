# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def task_created
    @task = params[:task]

    mail(to: @task.author.email, subject: 'New Task Created')
  end

  def task_updated
    @task = params[:task]

    mail(to: @task.author.email, subject: "Task #{@task.id} Updated")
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
