# frozen_string_literal: true

class EmailForm
  include ActiveModel::Model
  
  attr_accessor(
    :email
  )

  validates :email, presence: true, format: { with: /@/ }
  validates :user, presence: true

  def user
    User.find_by(email: email)
  end
end
