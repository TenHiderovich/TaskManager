# frozen_string_literal: true

class EmailForm
  include ActiveModel::Model

  attr_accessor(
    :email
  )

  validates :email, presence: true, format: { with: /@/ }
  validate :user_valid?

  def user
    User.find_by(email: email)
  end

  private

  def user_valid?
    errors.add(:email, "email doesn't match") if user.blank?
  end
end
