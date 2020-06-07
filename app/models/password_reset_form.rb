# frozen_string_literal: true

class PasswordResetForm
  include ActiveModel::Model

  attr_accessor(
    :password,
    :password_confirmation
  )

  validates :password, presence: true, confirmation: true
  validates_confirmation_of :password
end
