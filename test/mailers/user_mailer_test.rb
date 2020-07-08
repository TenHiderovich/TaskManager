# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'task created' do
    user = create(:user)
    task = create(:task, author: user)
    params = { user: user, task: task }
    email = UserMailer.with(params).task_created

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'New Task Created', email.subject
    assert email.body.to_s.include?("Task #{task.id} was created")
  end

  test 'task updated' do
    user = create(:user)
    task = create(:task, author: user)
    params = { user: user, task: task }
    email = UserMailer.with(params).task_updated

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [user.email], email.to
    assert_equal "Task #{task.id} Updated", email.subject
    assert email.body.to_s.include?("Task #{task.id} was updated")
  end

  test 'task destroyed' do
    user = create(:user)
    task = create(:task, author: user)
    params = { email: user.email, task_id: task.id }
    email = UserMailer.with(params).task_destroyed

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [user.email], email.to
    assert_equal "Task #{task.id} Destroyed", email.subject
    assert email.body.to_s.include?("Task #{task.id} was destroyed")
  end

  test 'email checked' do
    user = create(:user)
    user.reset_token = user.new_reset_token
    email = user.email

    params = { user: user }
    email = UserMailer.with(params).email_checked

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'password reseted', email.subject
  end
end
