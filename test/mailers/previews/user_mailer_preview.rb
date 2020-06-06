# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def task_created
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_created
  end

  def task_updated
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_updated
  end

  def task_destroyed
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_destroyed
  end

  def email_checked
    user = User.first
    email = user.email
    params = { email: email }

    UserMailer.with(params).email_checked
  end
end
