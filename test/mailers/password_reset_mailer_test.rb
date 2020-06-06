require 'test_helper'

class PasswordResetMailerTest < ActionMailer::TestCase
  test "email checked" do
    user = create(:user)
    email = user.email
    params = { email: email }
    email = PasswordResetMailer.with(params).email_checked

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'password reseted', email.subject
    assert email.body.to_s.include?("Check your email")
  end
end