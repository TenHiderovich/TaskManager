class UserMailer < ApplicationMailer
  def task_created
    user = params[:user]
    @task = params[:task]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'New Task Created')
  end

  def task_updated
    user = params[:user]
    @task = params[:task]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: "Task #{@task.id} Updated")
  end

  def task_destroyed
    user = params[:user]
    @task = params[:task]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: "Task #{@task.id} Destroyed")
  end

  def email_checked
    email = params[:email]

    mail(from: 'noreply@taskmanager.com', to: email, subject: 'password reseted')
  end
end
