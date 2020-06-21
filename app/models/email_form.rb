# frozen_string_literal: true

class EmailForm
  include ActiveModel::Model

  attr_accessor(
    :email
  )

  validates :email, presence: true, format: { with: /@/ }

  def user
    User.find_by(email: email)
  end

  def has_user?
    !user.blank?
  end
end
